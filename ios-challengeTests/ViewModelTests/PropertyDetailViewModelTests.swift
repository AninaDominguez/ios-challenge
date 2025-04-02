//
//  PropertyDetailViewModelTests.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import XCTest
@testable import ios_challenge

final class PropertyDetailViewModelTests: XCTestCase {

    var detailServiceMock: PropertyDetailServiceMock!
    var storageMock: StorageManagerMock!
    var imageStorageMock: ImageStorageManagerMock!
    var viewModel: PropertyDetailViewModel!

    override func setUp() {
        super.setUp()
        detailServiceMock = PropertyDetailServiceMock()
        storageMock = StorageManagerMock()
        imageStorageMock = ImageStorageManagerMock()
        viewModel = PropertyDetailViewModel(
            detailService: detailServiceMock,
            dataStorage: storageMock,
            imageStorage: imageStorageMock,
            propertyCode: "1"
        )
    }

    func testSuccessfulLoad() async {
        await viewModel.loadPropertyDetail()

        XCTAssertNotNil(viewModel.detail)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(storageMock.saveObjectWasCalled, 1)
        XCTAssertEqual(imageStorageMock.loadImagesCalled, 1)
    }

    func testWrongPropertyCodeShowsError() async {
        viewModel = PropertyDetailViewModel(
            detailService: detailServiceMock,
            dataStorage: storageMock,
            imageStorage: imageStorageMock,
            propertyCode: "999"
        )

        await viewModel.loadPropertyDetail()

        XCTAssertNil(viewModel.detail)
        XCTAssertEqual(viewModel.errorMessage, String(localized: "property_not_available"))
    }

    func testLoadsFromCacheIfServiceFails() async {
        detailServiceMock.shouldFail = true

        await viewModel.loadPropertyDetail()

        XCTAssertNotNil(viewModel.detail)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(storageMock.getObjectWasCalled, 1)
    }

    func testImagesAreLoaded() async {
        await viewModel.loadPropertyDetail()

        XCTAssertFalse(viewModel.images.isEmpty)
        XCTAssertEqual(imageStorageMock.loadImagesCalled, 1)
    }
}

