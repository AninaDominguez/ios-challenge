//
//  PropertyDetailViewModelMock.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import XCTest
@testable import ios_challenge

final class PropertyDetailViewModelMock: PropertyDetailViewModelProtocol {
    var images: [UIImage] = []
    var propertyCode: String = ""
    var errorMessage: String?
    var loadPropertyDetail = 0
    
    func loadPropertyDetail() async {
        loadPropertyDetail += 1
    }
}
