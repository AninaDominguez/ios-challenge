//
//  FavoritesManagerMock.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import Foundation
@testable import ios_challenge

final class FavoritesManagerMock: FavoritesManagingProtocol {
    func add(propertyCode: String) async {
        <#code#>
    }
    
    func remove(propertyCode: String) async {
        <#code#>
    }
    
    func isFavorite(propertyCode: String) async -> Date? {
        <#code#>
    }
    
    func getFavorites() async -> [ios_challenge.FavoriteProperty] {
        <#code#>
    }
}
