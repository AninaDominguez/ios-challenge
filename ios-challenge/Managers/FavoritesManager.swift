//
//  FavoritesManager.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import Foundation

protocol FavoritesManagerProtocol {
    func add(propertyCode: String) async
    func remove(propertyCode: String) async
    func isFavorite(propertyCode: String) async -> Date?
    func getFavorites() async -> [FavoriteProperty]
}

actor FavoritesManager: FavoritesManagerProtocol {
    private let filename = "favorite_properties"
    private let storageManager = StorageManager()

    func add(propertyCode: String) async {
        var favorites = await getFavorites()
        favorites.removeAll { $0.propertyCode == propertyCode }
        favorites.append(FavoriteProperty(propertyCode: propertyCode, dateFavorited: Date()))
        try? await storageManager.saveObject(object: favorites, filename: filename)
    }

    func remove(propertyCode: String) async {
        var favorites = await getFavorites()
        favorites.removeAll { $0.propertyCode == propertyCode }
        try? await storageManager.saveObject(object: favorites, filename: filename)
    }

    func isFavorite(propertyCode: String) async -> Date? {
        let favorites = await getFavorites()
        return favorites.first(where: { $0.propertyCode == propertyCode })?.dateFavorited
    }

    func getFavorites() async -> [FavoriteProperty] {
        await (try? storageManager.getObject(filename: filename)) ?? []
    }
}

