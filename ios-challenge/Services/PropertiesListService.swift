//
//  PropertiesListService.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

final class PropertiesListService: PropertiesListServiceProtocol {

    private let networkManager: NetworkManagingProtocol

    init(networkManager: NetworkManagingProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    func getPropertiesList(from url: URL) async throws -> [Property] {
        let dtoList: [PropertyDTO] = try await networkManager.fetchData(url)
        return dtoList.compactMap(Property.init)
    }
}
