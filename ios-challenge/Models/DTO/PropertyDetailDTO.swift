//
//  PropertyDetailDTO.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

struct PropertyDetailDTO: Decodable {
    let adid: Int
    let price: Double
    let priceInfo: PriceDTO
    let operation: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let multimedia: MultimediaDetailDTO
    let propertyComment: String
    let ubication: UbicationDTO
    let country: String
    let moreCharacteristics: CharacteristicsDTO
    let energyCertification: EnergyCertificationDTO
}

struct MultimediaDetailDTO: Decodable {
    let images: [DetailImageDTO]
}

struct DetailImageDTO: Decodable {
    let url: String
    let tag: String
    let localizedName: String
    let multimediaId: Int
}

struct UbicationDTO: Decodable {
    let latitude: Double
    let longitude: Double
}

struct CharacteristicsDTO: Decodable {
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

struct EnergyCertificationDTO: Decodable {
    let title: String
    let energyConsumption: EnergyTypeDTO
    let emissions: EnergyTypeDTO
}

struct EnergyTypeDTO: Decodable {
    let type: String
}
