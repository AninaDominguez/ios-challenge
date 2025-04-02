//
//  PropertiesListViewControllerTests.swift
//  ios-challenge
//
//  Created by Anina Dominguez on 2/4/25.
//

import XCTest
@testable import ios_challenge

final class PropertiesListViewControllerTests: XCTestCase {

    var sut: PropertiesListViewController!
    var viewModelMock: PropertiesListViewModelMock!
    var delegateMock: PropertiesListViewControllerDelegateMock!

    override func setUp() {
        super.setUp()
        createSut()
    }

    override func tearDown() {
        super.tearDown()
        releaseSut()
    }

    func createSut() {
        viewModelMock = PropertiesListViewModelMock()
        delegateMock = PropertiesListViewControllerDelegateMock()
        sut = PropertiesListViewController(viewModel: viewModelMock)
        sut.delegate = delegateMock
    }

    func releaseSut() {
        sut = nil
        viewModelMock = nil
        delegateMock = nil
    }

    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.viewModel)
    }
    
    func testPullToRefreshTriggersLoad() {
        XCTAssertEqual(viewModelMock.loadPropertiesCalled, 0)
        _ = sut.view
        
        let firstCallExpectation = XCTestExpectation(description: "First call")
        viewModelMock.onLoadProperties = {
            if self.viewModelMock.loadPropertiesCalled == 1 {
                firstCallExpectation.fulfill()
            }
        }
        
        wait(for: [firstCallExpectation], timeout: 1.0)
        XCTAssertEqual(viewModelMock.loadPropertiesCalled, 1)
        
        let secondCallExpectation = XCTestExpectation(description: "Second call")
        viewModelMock.onLoadProperties = {
            if self.viewModelMock.loadPropertiesCalled == 2 {
                secondCallExpectation.fulfill()
            }
        }
        sut.didPullToRefresh()
        
        wait(for: [secondCallExpectation], timeout: 1.0)
        XCTAssertEqual(viewModelMock.loadPropertiesCalled, 2)
    }
    
    func testNumRowsInSection() {
        _ = sut.view
        sut.reloadInfo(data: TestConstants.allProperties)
        let tableView = sut.tableView!
        
        let num = TestConstants.allProperties.count
        let expected = sut.tableView(tableView, numberOfRowsInSection: 0)
        
        XCTAssertEqual(num, expected)
    }

    func testCellForRowAt() {
        _ = sut.view
        sut.reloadInfo(data: TestConstants.allProperties)
        let tableView = sut.tableView!
        let cell = sut.tableView(
            tableView,
            cellForRowAt: IndexPath(row: 0,section: 0)
        ) as! PropertyCellView
        
        let text = cell.districtText?.text
        let expected = TestConstants.property.district
        
        XCTAssertEqual(text, expected)
    }

    func testDidSelectDetail() {
        _ = sut.view
        XCTAssertEqual(delegateMock.showDetailCalled, 0)
        
        sut.reloadInfo(data: TestConstants.allProperties)
        let tableView = sut.tableView!
        let cell = sut.tableView(
            tableView,
            cellForRowAt: IndexPath(row: 0, section: 0)
        ) as! PropertyCellView
        
        cell.onDetailTapped?()
        
        let code = delegateMock.passedPropertyCode
        let expected = TestConstants.property.propertyCode
        
        XCTAssertEqual(delegateMock.showDetailCalled, 1)
        XCTAssertEqual(code, expected)
    }
    
    func testDidSelectFavorite() {
        _ = sut.view
        XCTAssertEqual(viewModelMock.toggleFavoriteCalled, 0)
        
        sut.reloadInfo(data: TestConstants.allProperties)
        
        let tableView = sut.tableView!
        let cell = sut.tableView(
            tableView,
            cellForRowAt: IndexPath(row: 0, section: 0)
        ) as! PropertyCellView

        let expectation = XCTestExpectation(description: "toggleFavorite called")

        viewModelMock.onToggleFavorite = {
            expectation.fulfill()
        }

        cell.onFavoriteTapped?()

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModelMock.toggleFavoriteCalled, 1)
    }
}

final class PropertiesListViewControllerDelegateMock: PropertiesListViewControllerDelegate {
    var showDetailCalled = 0
    var passedPropertyCode: String?

    func showDetail(propertyCode: String, sender: UIViewController) {
        showDetailCalled += 1
        passedPropertyCode = propertyCode
    }
}
