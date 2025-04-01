//
//  PropertyMapper.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

extension Property {
    init?(dto: PropertyDTO) {
        guard let thumbnailURL = URL(string: dto.thumbnail) else { return nil }
        self.id = dto.propertyCode
        self.thumbnail = thumbnailURL
        self.price = "\(Int(dto.priceInfo.price.amount)) \(dto.priceInfo.price.currencySuffix)"
        self.address = dto.address
        self.coordinates = (dto.latitude, dto.longitude)
        self.rooms = dto.rooms
        self.bathrooms = dto.bathrooms
        self.size = dto.size
    }
}
