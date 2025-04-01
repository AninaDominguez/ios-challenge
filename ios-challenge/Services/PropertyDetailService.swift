//
//  PropertyDetailService.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

final class PropertyDetailService: PropertyDetailServiceProtocol {

    private let networkManager: NetworkManagingProtocol

    init(networkManager: NetworkManagingProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    func getPropertyDetails(from url: URL) async throws -> PropertyDetail {
        let dto: PropertyDetailDTO = try await networkManager.fetchData(url)
        return PropertyDetail(dto: dto)
    }
}
