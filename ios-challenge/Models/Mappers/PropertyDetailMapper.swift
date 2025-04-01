//
//  PropertyDetailMapper.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

extension PropertyDetail {
    init(dto: PropertyDetailDTO) {
        self.id = dto.adid
        self.price = "\(Int(dto.priceInfo.amount)) \(dto.priceInfo.currencySuffix)"
        self.operation = dto.operation
        self.type = dto.extendedPropertyType
        self.state = dto.state
        self.comment = dto.propertyComment
        self.coordinates = (dto.ubication.latitude, dto.ubication.longitude)
        self.imageURLs = dto.multimedia.images.compactMap { URL(string: $0.url) }
        self.roomCount = dto.moreCharacteristics.roomNumber
        self.bathCount = dto.moreCharacteristics.bathNumber
        self.size = dto.moreCharacteristics.constructedArea
        self.isExterior = dto.moreCharacteristics.exterior
        self.energyType = dto.energyCertification.energyConsumption.type
    }
}
