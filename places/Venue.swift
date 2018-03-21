//
//  Venue.swift
//  places
//
//  Created by Marko Posio on 21/03/2018.
//  Copyright © 2018 Marko Posio. All rights reserved.
//

import Foundation

struct Location : Codable {
    let distance: Double
    let formattedAddress: String
}

struct Venue : Codable {
    let id: String
    let name: String
    let location: Location
}
