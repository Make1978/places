//
//  Venue.swift
//  places
//
//  Created by Marko Posio on 21/03/2018.
//  Copyright © 2018 Marko Posio. All rights reserved.
//

import Foundation

/*
 "response": {
 "venues": [
 {
 "id": "4acbe67af964a52044c820e3",
 "name": "Katz's Delicatessen",
 "contact": {
 "phone": "8004468364",
 "formattedPhone": "(800) 446-8364",
 "twitter": "katzsdeli",
 "facebook": "89033874836",
 "facebookUsername": "katzsdeli",
 "facebookName": "Katz's Delicatessen"
 },
 "location": {
 "address": "205 E Houston St",
 "crossStreet": "at Ludlow St",
 "lat": 40.72216120993533,
 "lng": -73.98721255191126,
 "distance": 0,
 "postalCode": "10002",
 "cc": "US",
 "neighborhood": "Lower East Side",
 "city": "New York",
 "state": "NY",
 "country": "United States",
 "contextLine": "Lower East Side",
 "contextGeoId": 7643,
 "formattedAddress": [
 "205 E Houston St (at Ludlow St)",
 "New York, NY 10002"
 ]
 },*/

//struct FormattedAddress {
//
//}

struct Location : Codable {
    let distance: Double
    let formattedAddress: [String]
}

struct Venue : Codable {
    let id: String
    let name: String
    let location: Location
}


struct JsonResponse : Codable {
    
    struct Meta : Codable {
        let requestId: String
    }
    
    struct Response : Codable {
        let venues: [Venue]
    }
    
    let meta : Meta
    let response : Response
}


