//
//  Property.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

struct PropertyDTO: Decodable {
    let propertyCode: String
    let thumbnail: String
    let floor: String?
    let price: Double
    let priceInfo: PriceInfoDTO
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
    let multimedia: MultimediaDTO
    let features: FeaturesDTO
}

struct PriceInfoDTO: Decodable {
    let price: PriceDTO
}

struct PriceDTO: Decodable {
    let amount: Double
    let currencySuffix: String
}

struct MultimediaDTO: Decodable {
    let images: [PropertyImageDTO]
}

struct PropertyImageDTO: Decodable {
    let url: String
    let tag: String
}

struct FeaturesDTO: Decodable {
    let hasAirConditioning: Bool?
    let hasBoxRoom: Bool?
}
