//
//  NetworkError.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case generic
    case network

    var errorDescription: String? {
        switch self {
        case .generic:
            return String(localized: "error_generic")
        case .network:
            return String(localized: "error_network")
        }
    }
}
