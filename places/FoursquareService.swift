//
//  foursquareService.swift
//  places
//
//  Created by Marko Posio on 21/03/2018.
//  Copyright © 2018 Marko Posio. All rights reserved.
//

import Foundation
import CoreLocation

class FoursquareService {
    
    let API_URL = "https://api.foursquare.com/v2/"
    let CLIENT_ID = "CYEMKOM4OLTP5PHMOFVUJJAMWT5CH5G1JBCYREATW21XLLSZ"
    let CLIENT_SECRET = "GYNP4URASNYRNRGXR5UEN2TGTKJHXY5FGSAXTIHXEUG1GYM2"
    
    var dataTask: URLSessionDataTask?
    
    func searchVenues( keyword: String, location: CLLocation, callback:@escaping ([Venue]) -> Void ) {
        do {
            let requestString = "\(API_URL)venues/search?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20180326&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)&radius=500&query=\(keyword)"
            guard let url = URL(string: requestString) else { return }
            
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                defer { self.dataTask = nil }
                if let error = error {
                    // TODO:
                } else if let responseData = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    
                    do {
                        print("data =\(responseData)")
                        let decoder = JSONDecoder()
                        let venues = try decoder.decode(JsonResponse.self, from: responseData)
                        dump(venues)
                        DispatchQueue.main.async {
                            callback(venues.response.venues)
                        }
                    } catch {
                        
                    }
                    
                }
            })
            dataTask?.resume()
        }
        catch {
            
        }
    }
    
    
}
