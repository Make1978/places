//
//  placesTests.swift
//  placesTests
//
//  Created by Marko Posio on 21/03/2018.
//  Copyright © 2018 Marko Posio. All rights reserved.
//

import XCTest
import CoreLocation
@testable import places

class FoursquareServiceMock: FoursquareService {
    private let venues: [Venue]
    init( venues: [Venue] ) {
        self.venues = venues;
    }
    override func searchVenues(keyword: String, location: CLLocation, callback: @escaping ([Venue]) -> Void) {
        callback(venues)
    }
}

class VenueViewMock : NSObject, VenueView {
    var startSearchingCalled = false
    var finishSearchingCalled = false
    var setVenuesCalled = false
    var setEmptyViewCalled = false
    
    func startSearching() {
        startSearchingCalled = true
    }
    
    func finishSearching() {
        finishSearchingCalled = true
    }
    
    func setEmptyVenues() {
        setEmptyViewCalled = true
    }
    
    func setVenues(venues: [VenuesViewData]) {
        setVenuesCalled = true
    }
}

class VenuePresenterTest: XCTestCase {
    
    let emptyVenueFoursquareMock = FoursquareServiceMock(venues: [])
    
    let oneVenueFoursquareMock = FoursquareServiceMock(venues: [
        Venue(id: "a", name: "b", location: Location(distance: 0, formattedAddress: [ "a" ]))])
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testActivityIndicatorStartStop() {
        let venueView = VenueViewMock()
        let presenterUnderTest = VenuePresenter(foursquareService: emptyVenueFoursquareMock)
        presenterUnderTest.attachView(view: venueView)
        presenterUnderTest.setLocation(location: CLLocation(latitude: 65.01234, longitude: 25.46816))
        presenterUnderTest.searchVenues(keyword: " asdf")
        XCTAssertTrue(venueView.finishSearchingCalled && venueView.startSearchingCalled)
    }
    
    func testShouldSetEmptyView() {
        let venueView = VenueViewMock()
        let presenterUnderTest = VenuePresenter(foursquareService: emptyVenueFoursquareMock)
        presenterUnderTest.attachView(view: venueView)
        presenterUnderTest.setLocation(location: CLLocation(latitude: 65.01234, longitude: 25.46816))
        presenterUnderTest.searchVenues(keyword: " asdf")
        XCTAssertTrue(venueView.setEmptyViewCalled)
    }
    
    func testShouldSetVenues() {
        let venueView = VenueViewMock()
        
        let presenterUnderTest = VenuePresenter(foursquareService: oneVenueFoursquareMock)
        presenterUnderTest.attachView(view: venueView)
        presenterUnderTest.setLocation(location: CLLocation(latitude: 65.01234, longitude: 25.46816))
        presenterUnderTest.searchVenues(keyword: " asdf")
        XCTAssertTrue(venueView.setVenuesCalled)
    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
