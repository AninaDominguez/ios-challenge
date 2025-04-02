//
//  ImageStorageManager.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import UIKit

protocol ImageStorageManagingProtocol {
    func loadImages(from urls: [String]) async -> [UIImage]
}

actor ImageStorageManager: ImageStorageManagingProtocol {
    init() { }

    private let fileManager = FileManager.default
    private var cacheDirectory: URL {
        fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }

    private func saveImage(_ image: UIImage, with identifier: String) {
        let fileURL = cacheDirectory.appendingPathComponent("\(identifier).jpg")
        if let data = image.jpegData(compressionQuality: 0.8) {
            try? data.write(to: fileURL)
        }
    }

    private func getCachedImage(with identifier: String) -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent("\(identifier).jpg")
        guard fileManager.fileExists(atPath: fileURL.path),
              let data = try? Data(contentsOf: fileURL),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }

    private func downloadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }

    func loadImages(from urls: [String]) async -> [UIImage] {
        var images: [UIImage] = []

        for (index, urlString) in urls.enumerated() {
            let identifier = urls[index]

            if let cached = getCachedImage(with: identifier) {
                images.append(cached)
            } else if let downloaded = await downloadImage(from: urlString) {
                saveImage(downloaded, with: identifier)
                images.append(downloaded)
            }
        }

        return images
    }
}
