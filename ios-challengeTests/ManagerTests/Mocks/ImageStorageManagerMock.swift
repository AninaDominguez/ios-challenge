//
//  ImageStorageManagerMock.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import UIKit
@testable import ios_challenge

final class ImageStorageManagerMock: ImageStorageManagingProtocol {
    var loadImagesCalled = 0
    
    func loadImages(from urls: [String]) async -> [UIImage] {
        loadImagesCalled += 1
        guard let image = UIImage(named: "placeholderImage") else {
            fatalError("Image not found")
        }
        return urls.map { _ in image }
    }
}
