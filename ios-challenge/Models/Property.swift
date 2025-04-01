//
//  Property.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

struct Property: Codable {
    let propertyCode: String
    let thumbnail: String
    let floor: String?
    let price: Double
    let priceInfo: PriceInfo
    let propertyType: String
    let operation: String
    let size: Double
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String
    let latitude: Double
    let longitude: Double
    let description: String
    let multimedia: Multimedia
    let features: Features
}

struct PriceInfo: Codable {
    let price: Price
}

struct Price: Codable {
    let amount: Double
    let currencySuffix: String
}

struct Multimedia: Codable {
    let images: [PropertyImage]
}

struct PropertyImage: Codable {
    let url: String
    let tag: String
}

struct Features: Codable {
    let hasAirConditioning: Bool?
    let hasBoxRoom: Bool?
}
