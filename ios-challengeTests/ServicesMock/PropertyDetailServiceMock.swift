//
//  PropertyDetailServiceMock.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import XCTest
@testable import ios_challenge

final class PropertyDetailServiceMock: PropertyDetailServiceProtocol {
    var shouldFail = false
    var returnNilURL = false

    func getPropertyDetails(from url: URL) async throws -> PropertyDetail {
        if shouldFail {
            throw NetworkError.generic
        }

        return TestConstants.propertyDetail
    }
}
