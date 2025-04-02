//
//  StorageManager.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

protocol StorageManagingProtocol {
    func saveObject<T: Encodable>(object: T, filename: String) async throws
    func getObject<T: Decodable>(filename: String) async throws -> T
}

actor StorageManager: StorageManagingProtocol {
    
    func saveObject<T: Encodable>(object: T, filename: String) throws {
        let objectToSave = try JSONEncoder().encode(object)
        let cachesDirectory = getCachesDirectory()
        let storageURL = cachesDirectory.appendingPathComponent("\(filename).json",
                                                                isDirectory: false)
        try objectToSave.write(to: storageURL)
    }
    
    func getObject<T>(filename: String) async throws -> T where T : Decodable {
        let cachesDirectory = getCachesDirectory()
        let storageURL = cachesDirectory.appendingPathComponent("\(filename).json",
                                                                isDirectory: false)
        let objectToGet = try Data(contentsOf: storageURL)
        let object = try JSONDecoder().decode(T.self, from: objectToGet)
        return object
    }
    
    private func getCachesDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
}
