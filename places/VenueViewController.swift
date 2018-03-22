//
//  ViewController.swift
//  places
//
//  Created by Marko Posio on 21/03/2018.
//  Copyright © 2018 Marko Posio. All rights reserved.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView?.dataSource = self
        activityIndicator?.hidesWhenStopped = true
        presenter.attachView(view: self)
        presenter.searchVenues(keyword: "")
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

