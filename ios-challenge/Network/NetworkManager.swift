//
//  NetworkManager.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

protocol NetworkManagingProtocol {
    func fetchData<T: Codable>(_ url: URL) async throws -> T
}

final class NetworkManager: NetworkManagingProtocol {
    
    func fetchData<T: Codable>(_ url: URL) async throws -> T {
        do {
            let data = try Data(contentsOf: url)
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw CustomError.generic
        }
    }
}
