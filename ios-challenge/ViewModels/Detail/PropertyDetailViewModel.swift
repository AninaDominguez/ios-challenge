//
//  PropertyDetailViewModel.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 1/4/25.
//

import UIKit

protocol PropertyDetailViewModelProtocol {
    var images: [UIImage] { get }
    var propertyCode: String { get }
    var errorMessage: String? { get }
    
    func loadPropertyDetail() async
}

final class PropertyDetailViewModel: ObservableObject, PropertyDetailViewModelProtocol {
    private let detailService: PropertyDetailServiceProtocol
    private let dataStorage: StorageManagingProtocol
    private let imageStorage: ImageStorageManagingProtocol
    private let storageName: String
    
    var propertyCode: String
    
    @Published var errorMessage: String? = nil
    @Published var images: [UIImage] = []
    @Published var detail: PropertyDetail?
    
    // MARK: - Init
    init(detailService: PropertyDetailServiceProtocol = PropertyDetailService(),
         dataStorage: StorageManagingProtocol = StorageManager(),
         imageStorage: ImageStorageManagingProtocol = ImageStorageManager(),
         propertyCode: String) {
        self.detailService = detailService
        self.dataStorage = dataStorage
        self.imageStorage = imageStorage
        self.propertyCode = propertyCode
        self.storageName = "cached_detail_\(propertyCode)"
    }

    
    // MARK: - Data request
    func loadPropertyDetail() async {
        do {
            guard let url = Bundle.main.url(forResource: "detail", withExtension: "json") else {
                await MainActor.run {
                    self.errorMessage = NetworkError.generic.errorDescription
                }
                return
            }
            let propertyDetail = try await detailService.getPropertyDetails(from: url)
            
            guard propertyDetail.adid == Int(propertyCode) else {
                await MainActor.run {
                    self.errorMessage = String(localized: "property_not_available")
                }
                return
            }
            await savePropertyDetailToStorage(propertyDetail, name: storageName)
            await saveImagesToStorage(propertyDetail)
            
            await MainActor.run {
                self.detail = propertyDetail
            }
        } catch let error {
            
            if let cachedDetail = await getPropertyDetailFromStorage(name: storageName) {
                self.detail = cachedDetail
            } else {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getPropertyType(_ type: String) -> String {
        return String(localized: "flat")
    }
    
    // MARK: - Images storage
    private func saveImagesToStorage(_ property: PropertyDetail) async {
        let imageUrls = property.multimedia.images.map { $0.url }
        let loaded = await imageStorage.loadImages(from: imageUrls)
        await MainActor.run {
            self.images = loaded
        }
    }

    
    // MARK: - Data storage
    private func savePropertyDetailToStorage(_ property: PropertyDetail, name: String) async {
        try? await dataStorage.saveObject(object: property, filename: name)
    }
    
    private func getPropertyDetailFromStorage(name: String) async -> PropertyDetail? {
        try? await dataStorage.getObject(filename: name)
    }
}
