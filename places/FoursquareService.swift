//
//  foursquareService.swift
//  places
//
//  Created by Marko Posio on 21/03/2018.
//  Copyright © 2018 Marko Posio. All rights reserved.
//

import Foundation

class FoursquareService {
    func searchVenues( keyword: String, callback:([Venue]) -> Void ) {
        // TODO: return mocked data
        let venues = [ Venue(id:"4acbe67af964a52044c820e3",
                             name:"Katz's Delicatessen",
                             location: Location(distance: 5.23, formattedAddress: "street 1, 12345 city")) ]
        callback(venues)
    }
}
