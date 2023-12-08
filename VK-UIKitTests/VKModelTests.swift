//
//  VKModelTests.swift
//  VK-UIKitTests
//
//  Created by Daniil Rassadin on 7/12/23.
//

import XCTest
@testable import VK_UIKit

final class VKModelTests: XCTestCase {
    private var networkService: NetworkServiceMock!
    private var dataService: DataServiceSpy!
    private var model: VKModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        networkService = NetworkServiceMock()
        dataService = DataServiceSpy()
        model = VKModel(networkService: networkService, dataService: dataService)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        model = nil
    }
    
    func testGetFriendsUpdateDate() {
        _ = model.getFriendsUpdateDate()
        XCTAssertTrue(
            dataService.getFriendsUpdateDateWasCalled,
            "The data service's method getFriendsUpdateDate wasn't called."
        )
    }
    
    func testDownloadFriends() {
        model.downloadFriends { _ in }
        XCTAssertTrue(networkService.getFriendsWasCalled, "The network service's method getFriends wasn't called.")
        XCTAssertTrue(dataService.addFriendsWasCalled, "The data service's method add(friends:) wasn't called.")
    }
    
    func testDownloadUser() {
        model.downloadUser(with: nil) { _ in }
        XCTAssertTrue(networkService.getUserWasCalled, "The network service's method getUser wasn't called.")
    }
    
    func testGetGroupsUpdateDate() {
        _ = model.getGroupsUpdateDate()
        XCTAssertTrue(
            dataService.getGroupsUpdateDateWasCalled,
            "The data service's method getGroupsUpdateDate wasn't called."
        )
    }
    
    func testDownloadGroups() {
        model.downloadGroups { _ in }
        XCTAssertTrue(networkService.getGroupsWasCalled, "The network service's method getGroups wasn't called.")
        XCTAssertTrue(dataService.addGroupsWasCalled, "The data service's method add(groups:) wasn't called.")
    }
    
    func testDownloadPhotos() {
        model.downloadPhotos { _ in }
        XCTAssertTrue(networkService.getPhotosWasCalled, "The network service's method getPhotos wasn't called.")
    }
}
