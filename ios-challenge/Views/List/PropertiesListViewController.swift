//
//  PropertiesListViewController.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 31/3/25.
//

import UIKit

protocol BaseProtocol: AnyObject {
    func showError(_ message: String)
}

protocol ViewProtocol: BaseProtocol {
    func reloadInfo(data: [Property])
}

class PropertiesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: PropertiesListViewModelProtocol?
    var delegate: PropertiesListViewControllerDelegate?
    private var properties: [Property] = []
    private let refreshControl = UIRefreshControl()

    public convenience init(viewModel: PropertiesListViewModelProtocol) {
        self.init(nibName: "PropertiesListViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProperties()
        setUpView()
        viewModel?.view = self
    }
    
    func loadProperties() {
        Task {
            await viewModel?.loadProperties()
            await viewModel?.loadFavorites()
        }
    }
    
    func setUpView() {
        tableView.register(UINib(nibName: "PropertyCellView",
                                 bundle: nil),
                                 forCellReuseIdentifier: "PropertyCellView")
        tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(didPullToRefresh),
                                 for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func handleDetailTapped(for propertyCode: String) {
        delegate?.showDetail(propertyCode: propertyCode, sender: self)
    }
    
    private func handleFavoriteTapped(for propertyCode: String, cell: PropertyCellView) {
        Task {
            if let date = await viewModel?.toggleFavorite(propertyCode: propertyCode) {
                await MainActor.run {
                    cell.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    cell.favoriteDateText.text = date.format()
                }
            } else {
                await MainActor.run {
                    cell.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    cell.favoriteDateText.text = nil
                }
            }
        }
    }
}

// MARK: - BaseProtocol
extension PropertiesListViewController: ViewProtocol {
    func reloadInfo(data: [Property]) {
        properties = data
        DispatchQueue.main.async { [self] in
            tableView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        if !message.isEmpty {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    @objc private func didPullToRefresh() {
        loadProperties()
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: - TableView
extension PropertiesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PropertyCellView",
            for: indexPath
        ) as? PropertyCellView else {
            return PropertyCellView()
        }
        
        let property = properties[indexPath.row]
        let propertyCode = property.propertyCode
        let isFavorite = viewModel?.isFavorite(propertyCode: property.propertyCode)
        let dateString = isFavorite?.format()

        cell.configure(
            with: property,
            isFavorite: isFavorite != nil,
            favoriteDate: dateString,
            image: viewModel?.getImage(name: property.thumbnail),
            priceText: viewModel?.getOperationType(
                operation: property.operation,
                amount: property.priceInfo.price.amount,
                currency: property.priceInfo.price.currencySuffix
            )
        )
        cell.onDetailTapped = { [weak self] in
            guard let self = self else { return }
            self.handleDetailTapped(for: propertyCode)
        }
        cell.onFavoriteTapped = { [weak self] in
            guard let self = self else { return }
            self.handleFavoriteTapped(for: propertyCode, cell: cell)
        }
        return cell
    }
}
