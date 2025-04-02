//
//  StorageManagerTests.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import XCTest
@testable import ios_challenge

final class StorageManagerTests: XCTestCase {

    let filename = "test_storage"
    let storageManager = StorageManager()

    override func tearDown() {
        let url = FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )[0].appendingPathComponent("\(filename).json")
        
        try? FileManager.default.removeItem(at: url)
        super.tearDown()
    }

    func testSaveAndGetObject() async throws {
        let object = SimpleMock(id: 1, name: "TestUser")

        try await storageManager.saveObject(object: object, filename: filename)
        let retrieved: SimpleMock = try await storageManager.getObject(filename: filename)

        XCTAssertEqual(retrieved, object)
    }
}

struct SimpleMock: Codable, Equatable {
    let id: Int
    let name: String
}

