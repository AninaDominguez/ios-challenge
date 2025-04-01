//
//  PropertyDetail.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

struct PropertyDetail {
    let id: Int
    let price: String
    let operation: String
    let type: String
    let state: String
    let comment: String
    let coordinates: (lat: Double, lon: Double)
    let imageURLs: [URL]
    let roomCount: Int?
    let bathCount: Int?
    let size: Int?
    let isExterior: Bool?
    let energyType: String?
}
