//
//  PropertiesListViewModelTests.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import XCTest
@testable import ios_challenge

final class PropertiesListViewModelTests: XCTestCase {

    var listServiceMock: PropertiesListServiceMock!
    var storageMock: StorageManagerMock!
    var imageStorageMock: ImageStorageManagerMock!
    var favoritesMock: FavoritesManagerMock!
    var viewModel: PropertiesListViewModel!
    var viewMock: ViewProtocolMock!

    override func setUp() {
        super.setUp()
        listServiceMock = PropertiesListServiceMock()
        storageMock = StorageManagerMock()
        imageStorageMock = ImageStorageManagerMock()
        favoritesMock = FavoritesManagerMock()
        viewModel = PropertiesListViewModel(
            listService: listServiceMock,
            dataStorage: storageMock,
            imageStorage: imageStorageMock,
            favoritesManager: favoritesMock
        )
        viewMock = ViewProtocolMock()
        viewModel.view = viewMock
    }

    func testLoadPropertiesCallsReloadInfo() async {
        await viewModel.loadProperties()
        
        XCTAssertTrue(viewMock.didReload)
        XCTAssertEqual(imageStorageMock.loadImagesCalled, 1)
        XCTAssertEqual(storageMock.saveObjectWasCalled, 1)
    }

    func testLoadFavoritesStoresFavoriteCodes() async {
        await viewModel.loadFavorites()
        
        XCTAssertEqual(viewModel.favoriteCodes.count, 1)
        XCTAssertEqual(viewModel.favoriteCodes["1"]?.formatted(), Date().formatted()) // misma fecha
    }

    func testToggleFavoriteAddsAndRemoves() async {
        favoritesMock.isFavoriteShouldReturn = nil
        
        let date = await viewModel.toggleFavorite(propertyCode: "2")
        XCTAssertNotNil(date)
        XCTAssertEqual(favoritesMock.addCalled, 1)
        
        favoritesMock.isFavoriteShouldReturn = Date()
        let removed = await viewModel.toggleFavorite(propertyCode: "2")
        XCTAssertNil(removed)
        XCTAssertEqual(favoritesMock.removeCalled, 1)
    }

    func testGetImageReturnsPlaceholder() {
        let image = viewModel.getImage(name: "doesntExist")
        XCTAssertNotNil(image)
    }

    func testGetOperationType() {
        let rent = viewModel.getOperationType(operation: "rent", amount: 1000, currency: "€")
        XCTAssertTrue(rent.contains("1000"))
        let sale = viewModel.getOperationType(operation: "sale", amount: 250000, currency: "€")
        XCTAssertTrue(sale.contains("250000"))
    }
}

final class ViewProtocolMock: ViewProtocol {
    var didReload = false
    var reloadedData: [Property] = []
    var didShowError = false

    func reloadInfo(data: [Property]) {
        didReload = true
        reloadedData = data
    }

    func showError(_ message: String) {
        didShowError = true
    }
}
