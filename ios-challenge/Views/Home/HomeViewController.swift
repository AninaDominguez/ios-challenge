//
//  HomeViewController.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var languageButton: UIButton!
    
    var onGoToList: (() -> Void)?
    var onGoToMap: (() -> Void)?
    
    private var availableLanguages: [String] = []
    private var selectedLanguageCode: String?
    
    public convenience init() {
        self.init(nibName: "HomeViewController", bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabelsAnButtons()
        loadAvailableLanguages()
        setupLanguages()
    }
    
    private func setUpLabelsAnButtons() {
        languageButton.layer.cornerRadius = 15
        titleLabel.text = String(localized: "welcome_title")
        listButton.setTitle(String(localized: "welcome_select_list"), for: .normal)
        mapButton.setTitle(String(localized: "welcome_select_map"), for: .normal)
    }
    
    private func setupLanguages() {
        guard let current = Locale.current.language.languageCode else { return }
        let languageCode = current.identifier
        
        let menuItems = availableLanguages.map { code in
            let displayName = Locale.current.localizedString(forIdentifier: code) ?? code

            return UIAction(title: displayName.capitalized,
                            image: languageCode == code ? UIImage(systemName: "checkmark") : nil,
                            attributes: [.disabled]) { _ in }
        }

        let menu = UIMenu(title: String(localized: "welcome_languages"),
                          options: .displayInline,
                          children: menuItems)
        languageButton.menu = menu
        languageButton.showsMenuAsPrimaryAction = true
    }
    
    private func loadAvailableLanguages() {
        availableLanguages = Bundle.main.localizations
            .filter { $0 != "Base" }
            .sorted()
    }
    
    @IBAction func didTapListButton(_ sender: UIButton) {
        onGoToList?()
    }
    
    @IBAction func didTapMapButton(_ sender: UIButton) {
        onGoToMap?()
    }
}
