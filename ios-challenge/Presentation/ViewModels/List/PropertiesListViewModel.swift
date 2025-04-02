//
//  PropertiesListViewModel.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import UIKit

protocol PropertiesListViewModelProtocol {
    var images: [String: UIImage] { get }
    var view: ViewProtocol? { get set }
    
    func loadProperties() async
    func getImage(name: String) -> UIImage
    func getOperationType(operation: String, amount: Double, currency: String) -> String
    func loadFavorites() async
    func toggleFavorite(propertyCode: String) async -> Date?
    func isFavorite(propertyCode: String) -> Date?
}

final class PropertiesListViewModel: PropertiesListViewModelProtocol {
    private let listService: PropertiesListServiceProtocol
    private let dataStorage: StorageManagingProtocol
    private let imageStorage: ImageStorageManagingProtocol
    private let favoritesManager: FavoritesManagingProtocol
    private let storageName = "cached_properties"
    private(set) var images: [String: UIImage] = [:]
    private(set) var favoriteCodes: [String: Date] = [:]
    weak var view: ViewProtocol?

    // MARK: - Init
    init(listService: PropertiesListServiceProtocol = PropertiesListService(),
         dataStorage: StorageManagingProtocol = StorageManager(),
         imageStorage: ImageStorageManagingProtocol = ImageStorageManager(),
         favoritesManager: FavoritesManagingProtocol = FavoritesManager()) {
        self.listService = listService
        self.dataStorage = dataStorage
        self.imageStorage = imageStorage
        self.favoritesManager = favoritesManager
    }

    // MARK: - Data request
    func loadProperties() async {
        do {
            guard let url = Bundle.main.url(forResource: "list", withExtension: "json") else {
                await MainActor.run {
                    self.view?.showError(String(localized: "error_generic"))
                }
                return
            }
            
            let properties = try await listService.getPropertiesList(from: url)
            let orderedProperties = prioritizeFavorites(in: properties)
            
            await saveImagesToStorage(orderedProperties)
            await savePropertiesToStorage(properties, name: storageName)
            
            await MainActor.run {
                self.view?.reloadInfo(data: orderedProperties)
            }
        } catch let error {
            if let cachedProperties = await getPropertiesFromStorage(name: storageName) {
                let orderedProperties = prioritizeFavorites(in: cachedProperties)
                
                await MainActor.run {
                    self.view?.reloadInfo(data: orderedProperties)
                }
            } else {
                await MainActor.run {
                    self.view?.showError(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Images storage
    private func saveImagesToStorage(_ properties: [Property]) async {
        let urls = properties.map { $0.thumbnail }
        let loaded = await imageStorage.loadImages(from: urls)

        for (index, urlString) in urls.enumerated() {
            if index < loaded.count {
                images[urlString] = loaded[index]
            }
        }
    }
    
    func getImage(name: String) -> UIImage {
        images[name] ?? UIImage(named: "placeholderImage")!
    }
    
    // MARK: - Data storage
    private func savePropertiesToStorage(_ properties: [Property], name: String) async {
        try? await dataStorage.saveObject(object: properties,
                                    filename: name)
    }
    
    private func getPropertiesFromStorage(name: String) async -> [Property]? {
        try? await dataStorage.getObject(filename: storageName)
    }
    
    private func prioritizeFavorites(in properties: [Property]) -> [Property] {
        return properties.sorted { prop1, prop2 in
            let prop1IsFav = favoriteCodes[prop1.propertyCode] != nil
            let prop2IsFav = favoriteCodes[prop2.propertyCode] != nil

            if prop1IsFav == prop2IsFav {
                return prop1.propertyCode < prop2.propertyCode
            }

            return prop1IsFav && !prop2IsFav
        }
    }
    
    // MARK: - Favorites storage
    func toggleFavorite(propertyCode: String) async -> Date? {
        if let _ = await favoritesManager.isFavorite(propertyCode: propertyCode) {
            await favoritesManager.remove(propertyCode: propertyCode)
            return nil
        } else {
            await favoritesManager.add(propertyCode: propertyCode)
            return Date()
        }
    }

    func loadFavorites() async {
        let favorites = await favoritesManager.getFavorites()
        self.favoriteCodes = Dictionary(uniqueKeysWithValues: favorites.map {
            ($0.propertyCode, $0.dateFavorited)
        })
    }

    func isFavorite(propertyCode: String) -> Date? {
        favoriteCodes[propertyCode]
    }

    // MARK: - Info
    func getOperationType(operation: String, amount: Double, currency: String) -> String {
        if operation == "rent" {
            return "\(String(localized: "property_for_rent")) \(Int(amount))\(currency)"
        } else if operation == "sale" {
            return "\(String(localized: "property_for_sale")) \(Int(amount))\(currency)"
        }
        return ""
    }
}
