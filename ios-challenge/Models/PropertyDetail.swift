//
//  PropertyDetail.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

struct PropertyDetail: Codable {
    let adid: Int
    let price: Double
    let priceInfo: Price
    let operation: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let multimedia: MultimediaDetail
    let propertyComment: String
    let ubication: Ubication
    let country: String
    let moreCharacteristics: Characteristics
    let energyCertification: EnergyCertification
}

struct MultimediaDetail: Codable {
    let images: [DetailImage]
}

struct DetailImage: Codable {
    let url: String
    let tag: String
    let localizedName: String
    let multimediaId: Int
}

struct Ubication: Codable {
    let latitude: Double
    let longitude: Double
}

struct Characteristics: Codable {
    let communityCosts: Double?
    let roomNumber: Int?
    let bathNumber: Int?
    let exterior: Bool?
    let housingFurnitures: String?
    let agencyIsABank: Bool?
    let energyCertificationType: String?
    let flatLocation: String?
    let modificationDate: TimeInterval?
    let constructedArea: Int?
    let lift: Bool?
    let boxroom: Bool?
    let isDuplex: Bool?
    let floor: String?
    let status: String?
}

struct EnergyCertification: Codable {
    let title: String
    let energyConsumption: EnergyType
    let emissions: EnergyType
}

struct EnergyType: Codable {
    let type: String
}
