//
//  Property.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

struct Property {
    let id: String
    let thumbnail: URL
    let price: String
    let address: String
    let coordinates: (lat: Double, lon: Double)
    let rooms: Int
    let bathrooms: Int
    let size: Double
}
