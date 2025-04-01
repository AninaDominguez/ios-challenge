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

class PropertiesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: PropertiesListViewModelProtocol?
    private var properties: [Property] = []

    public convenience init(viewModel: PropertiesListViewModelProtocol) {
        self.init(nibName: "PropertiesListViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await viewModel?.loadProperties()
        }
    }
}
// MARK: - BaseProtocol
extension PropertiesListViewController: BaseProtocol {
    
    func showError(_ message: String) {
        if !message.isEmpty {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
}

// MARK: - TableView
extension PropertiesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let property = properties[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PropertyCell", for: indexPath)
        cell.textLabel?.text = property.address
        
        return cell
    }
}
