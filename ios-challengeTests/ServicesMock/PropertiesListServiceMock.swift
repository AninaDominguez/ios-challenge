//
//  PropertiesListServiceMock.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import XCTest
@testable import ios_challenge

final class PropertiesListServiceMock: PropertiesListServiceProtocol {
    var shouldFail = false
    var returnNilURL = false

    func getPropertiesList(from url: URL) async throws -> [Property] {
        if shouldFail {
            throw NetworkError.generic
        }

        return TestConstants.allProperties
    }
}
