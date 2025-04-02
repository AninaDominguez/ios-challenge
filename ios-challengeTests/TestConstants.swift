//
//  TestConstants.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import XCTest
@testable import ios_challenge

struct TestConstants {
    // List
    static let property = Property(
        propertyCode: "codeMock",
        thumbnail: "urlMock",
        floor: "1",
        price: 1.00,
        priceInfo: PriceInfo(price: Price(amount: 1.00,
                                          currencySuffix: "eur")),
        propertyType: "flatMock",
        operation: "rentMock",
        size: 1.00,
        exterior: true,
        rooms: 1,
        bathrooms: 1,
        address: "addressMock",
        province: "provinceMock",
        municipality: "municipalityMock",
        district: "districtMock",
        country: "countryMock",
        neighborhood: "neighborhoodMock",
        latitude: 43.00,
        longitude: 43.00,
        description: "descriptionMock",
        multimedia: Multimedia(images: [PropertyImage(url: "urlMock",
                                                      tag: "tagMock")]),
        features: Features(hasAirConditioning: true,
                           hasBoxRoom: true)
    )
    static let allProperties: [Property] = [property]

    // Detail
    static let propertyDetail = PropertyDetail(
        adid: 1,
        price: 1.00,
        priceInfo: Price(amount: 1.00,
                         currencySuffix: "eur"),
        operation: "rent",
        propertyType: "propertyTypeMock",
        extendedPropertyType: "extendedPropertyTypeMock",
        homeType: "homeTypeMock",
        state: "stateMock",
        multimedia: MultimediaDetail(
            images: [DetailImage(
                url: "urlMock",
                tag: "tagMock",
                localizedName: "localizedNameMock",
                multimediaId: 1
            )]
        ),
        propertyComment: "propertyCommentMock",
        ubication: Ubication(latitude: 1.00, longitude: 1.00),
        country: "countryMock",
        moreCharacteristics: Characteristics(
            communityCosts: nil,
            roomNumber: 1,
            bathNumber: 1,
            exterior: true,
            housingFurnitures: nil,
            agencyIsABank: nil,
            energyCertificationType: nil,
            flatLocation: nil,
            modificationDate: nil,
            constructedArea: nil,
            lift: nil,
            boxroom: nil,
            isDuplex: nil,
            floor: nil,
            status: nil
        ),
        energyCertification: EnergyCertification(
            title: "titleMock",
            energyConsumption: EnergyType(type: "typeMock"),
            emissions: EnergyType(type: "typeMock")
        )
    )
}
