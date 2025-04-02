//
//  StorageManagerTests.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import Foundation
@testable import ios_challenge

final class StorageManagerMock: StorageManagingProtocol {
    var saveObjectWasCalled = 0
    var getObjectWasCalled = 0
    
    func saveObject<T>(object: T, filename: String) async throws where T : Encodable {
        saveObjectWasCalled += 1
    }
    
    func getObject<T>(filename: String) async throws -> T where T : Decodable {
        return ""
        getObjectWasCalled += 1
    }
}
