//
//  PropertiesListResponse.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import Foundation

struct PropertiesListResponse: Decodable {
    let property: [PropertyDTO]
}
