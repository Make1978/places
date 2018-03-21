//
//  VenuePresenter.swift
//  places
//
//  Created by Marko Posio on 21/03/2018.
//  Copyright © 2018 Marko Posio. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double {
        return NumberFormatter().number(from: self)?.doubleValue ?? 0
    }
}

class VenuePresenter {
    private let foursquareService: FoursquareService;
    weak private var venueView :VenueView?
    
    init( foursquareService: FoursquareService){
        self.foursquareService = foursquareService
    }
    
    func attachView(view: VenueView) {
        venueView = view;
    }
    
    func detachView() {
        venueView = nil
    }
    
    func searchVenues(keyword: String) {
        self.venueView?.startSearching()
        foursquareService.searchVenues(keyword: keyword) { [weak self] venues in
            self?.venueView?.finnishSearching()
            if( venues.count == 0) {
                self?.venueView?.setEmptyVenues()
            } else {
                let mappedVenues = venues.map{
                    return VenuesViewData(name: "\($0.name)",
                        address: "\($0.location.formattedAddress)",
                        distance: "\($0.location.distance)".toDouble()
                    )
                }
                self?.venueView?.setVenues(venues: mappedVenues)
            }
        }
    }
    
}
