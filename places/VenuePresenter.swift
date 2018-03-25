//
//  VenuePresenter.swift
//  places
//
//  Created by Marko Posio on 21/03/2018.
//  Copyright © 2018 Marko Posio. All rights reserved.
//

import Foundation
import CoreLocation

extension String {
    func toDouble() -> Double {
        return NumberFormatter().number(from: self)?.doubleValue ?? 0
    }
}

class VenuePresenter {
    
    private let foursquareService: FoursquareService
    weak private var venueView :VenueView?
    private var currentLocation: CLLocation?
    
    init( foursquareService: FoursquareService){
        self.foursquareService = foursquareService
    }
    
    func setLocation(location: CLLocation) {
        currentLocation = location
    }
    
    func attachView(view: VenueView) {
        venueView = view;
    }
    
    func detachView() {
        venueView = nil
    }
    
    func searchVenues(keyword: String) {
        self.venueView?.startSearching()
        guard let location = currentLocation else {
            return
        }
        foursquareService.searchVenues(keyword: keyword, location: location) { [weak self] venues in
            self?.venueView?.finishSearching()
            if( venues.count == 0) {
                self?.venueView?.setEmptyVenues()
            } else {
                let mappedVenues = venues.map{
                    return VenuesViewData(name: "\($0.name)",
                        address: "\($0.location.formattedAddress.first)",
                        distance: "\($0.location.distance)".toDouble()
                    )
                }
                self?.venueView?.setVenues(venues: mappedVenues)
            }
        }
            
    }
    
}
