//
//  ServicesContract.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

protocol PropertiesListServiceProtocol {
    func getPropertiesList(from url: URL) async throws -> [Property]
}

protocol PropertyDetailServiceProtocol {
    func getPropertyDetails(from url: URL) async throws -> PropertyDetail
}
