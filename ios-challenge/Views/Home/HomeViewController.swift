//
//  HomeViewController.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var languageButton: UIButton!
    
    private var availableLanguages: [String] = []
    private var selectedLanguageCode: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
        setupLanguages()
    }
    
    private func setUpLabels() {
        titleLabel.text = String(localized: "welcome_title")
        nameLabel.text = String(localized: "welcome_name")
        nameTextField.placeholder = String(localized: "welcome_name_placeholder")
        languageButton.setTitle(String(localized: "welocome_select_language"), for: .normal)
    }
    
    private func setupLanguages() {
        loadAvailableLanguages()
        let menuItems = availableLanguages.map { code in
            let displayName = Locale.current.localizedString(forIdentifier: code) ?? code
            return UIAction(title: displayName.capitalized, handler: { [weak self] _ in
                self?.languageButton.setTitle(displayName.capitalized, for: .normal)
                self?.selectedLanguageCode = code
                print("Language: \(code)")
            })
        }
        
        let menu = UIMenu(options: .displayInline,
                          children: menuItems)
        languageButton.menu = menu
        languageButton.showsMenuAsPrimaryAction = true
    }
    
    private func loadAvailableLanguages() {
        availableLanguages = Bundle.main.localizations
            .filter { $0 != "Base" }
            .sorted()
    }
}
