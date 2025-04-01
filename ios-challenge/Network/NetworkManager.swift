//
//  NetworkManager.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

final class NetworkManager {
    
    func fetchData<T: Decodable>(_ url: URL) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.generic
            }
            
            return try JSONDecoder().decode(T.self, from: data)
            
        } catch let urlError as URLError where urlError.code == .notConnectedToInternet {
            throw NetworkError.network
            
        } catch {
            throw NetworkError.generic
        }
    }
}
