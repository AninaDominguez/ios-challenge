//
//  PropertiesListViewModelMock.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import XCTest
@testable import ios_challenge

final class PropertiesListViewModelMock: PropertiesListViewModelProtocol {
    weak var view: ViewProtocol?
    var propertiesToReturn: [Property] = []
    var images: [String : UIImage] = [:]
    var isFavoriteResponse: Date? = nil
    
    var loadPropertiesCalled = 0
    var loadFavoritesCalled = 0
    var toggleFavoriteCalled = 0
    
    var onToggleFavorite: (() -> Void)? = nil
    var onLoadProperties: (() -> Void)? = nil

    func loadProperties() async {
        loadPropertiesCalled += 1
        onLoadProperties?()
        await MainActor.run {
            view?.reloadInfo(data: propertiesToReturn)
        }
    }

    func toggleFavorite(propertyCode: String) async -> Date? {
        toggleFavoriteCalled += 1
        onToggleFavorite?()
        return isFavoriteResponse == nil ? Date() : nil
    }
    
    func loadFavorites() async {
        loadFavoritesCalled += 1
    }

    func isFavorite(propertyCode: String) -> Date? {
        return isFavoriteResponse
    }

    func getImage(name: String) -> UIImage {
        return UIImage()
    }

    func getOperationType(operation: String, amount: Double, currency: String) -> String {
        return "\(operation.capitalized): \(Int(amount))€"
    }
}
