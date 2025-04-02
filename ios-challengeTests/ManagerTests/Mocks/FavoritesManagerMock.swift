//
//  FavoritesManagerMock.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import Foundation
@testable import ios_challenge

final class FavoritesManagerMock: FavoritesManagingProtocol {
    var addCalled = 0
    var removeCalled = 0
    var isFavoriteCalled = 0
    var getFavoriteCalled = 0
    
    var isFavoriteShouldReturn: Date? = nil
    
    func add(propertyCode: String) async {
        addCalled += 1
    }
    
    func remove(propertyCode: String) async {
        removeCalled += 1
    }
    
    func isFavorite(propertyCode: String) async -> Date? {
        isFavoriteCalled += 1
        return isFavoriteShouldReturn
    }
    
    func getFavorites() async -> [FavoriteProperty] {
        getFavoriteCalled += 1
        return [FavoriteProperty(propertyCode: "1", dateFavorited: Date())]
    }
}
