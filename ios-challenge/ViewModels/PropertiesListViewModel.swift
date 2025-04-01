//
//  PropertiesListViewModel.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

protocol PropertiesListViewModelProtocol {
    var properties: [Property] { get }
    var errorMessage: String? { get }
    
    func loadProperties() async
    
}

final class PropertiesListViewModel: PropertiesListViewModelProtocol {
    
    private let listService: PropertiesListServiceProtocol
    var properties: [Property] = []
    var errorMessage: String? = nil

    weak var delegate: BaseProtocol?

    init(listService: PropertiesListServiceProtocol = PropertiesListService()) {
        self.listService = listService
    }

    func loadProperties() async {
        do {
            guard let url = Bundle.main.url(forResource: "list", withExtension: "json") else {
                self.errorMessage = CustomError.generic.errorDescription
                delegate?.showError(self.errorMessage ?? String(localized: "error_generic"))
                return
            }
            let properties = try await listService.getPropertiesList(from: url)
            self.properties = properties
            print(properties)
            savePropertiesToStorage(properties, name: "cached_properties")
            delegate?.showError("")
        } catch {
            if let cachedProperties = getPropertiesFromStorage(name: "cached_properties") {
                self.properties = cachedProperties
            } else {
                self.errorMessage = error.localizedDescription
                delegate?.showError(self.errorMessage ?? String(localized: "error_generic"))
            }
        }
    }
    
    private func savePropertiesToStorage(_ properties: [Property], name: String) {
        try? StorageManager.shared.saveObject(object: properties,
                                              filename: name)
    }
    
    private func getPropertiesFromStorage(name: String) -> [Property]? {
        do {
            let list: [Property] = try StorageManager.shared.getObject(filename: name)
            return list
        } catch {
            return nil
        }
    }
}
