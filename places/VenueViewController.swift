//
//  ViewController.swift
//  places
//
//  Created by Marko Posio on 21/03/2018.
//  Copyright © 2018 Marko Posio. All rights reserved.
//

import UIKit
import CoreLocation

struct VenuesViewData {
    let name: String
    let address: String
    let distance: Double
}

protocol VenueView: NSObjectProtocol {
    func startSearching()
    func finishSearching()
    func setVenues(venues: [VenuesViewData])
    func setEmptyVenues()
}

class VenueViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    private let presenter = VenuePresenter(foursquareService: FoursquareService())
    private var venuesToDisplay = [VenuesViewData]()
    
    //private var ll :String?
    
    lazy var locationManager : CLLocationManager = {
        $0.delegate = self
        return $0
    }(CLLocationManager())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView?.dataSource = self
        searchBar?.delegate = self
        activityIndicator?.hidesWhenStopped = true
        presenter.attachView(view: self)
        presenter.searchVenues(keyword: "")
        locationManager.requestLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension VenueViewController : VenueView {
    
    func startSearching() {
        activityIndicator?.startAnimating()
    }
    
    func finishSearching() {
        activityIndicator?.stopAnimating()
    }
    
    func setVenues(venues: [VenuesViewData]) {
        venuesToDisplay = venues
        tableView?.reloadData()
    }
    
    func setEmptyVenues() {
        // TODO: empty state
    }
}

extension VenueViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venuesToDisplay.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "VenueCell")
        let data = venuesToDisplay[indexPath.row]
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.address
        return cell
    }
}

extension VenueViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchVenues(keyword: searchText)
    }
}

extension VenueViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        presenter.setLocation(location: location)
        //ll = "\(location.coordinate.longitude),\(location.coordinate.latitude)"
        locationManager.stopUpdatingLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard CLLocationManager.locationServicesEnabled(),
            [ .authorizedAlways, .authorizedWhenInUse ].contains(CLLocationManager.authorizationStatus())
            else {
                locationManager.requestWhenInUseAuthorization()
                return
                
        }
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}

