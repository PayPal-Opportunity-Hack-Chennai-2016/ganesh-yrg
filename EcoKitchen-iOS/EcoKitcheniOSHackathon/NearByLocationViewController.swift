//
//  NearByLocationViewController.swift
//  EcoKitcheniOS
//
//  Created by mh53653 on 11/13/16.
//  Copyright © 2016 madan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NearByLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let serviceManager = ServiceManager()
        serviceManager.allLocations(completion: {(locations) in
            DispatchQueue.main.async {
                if locations.count > 0 {
                    for location in locations {
                        
                        if location.status {
                            
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = location.coordinate
                            annotation.title = "Eco Chain Food Stall"
                            annotation.subtitle = location.address
                            self.mapView.addAnnotation(annotation)
                            let region = MKCoordinateRegion(center: annotation.coordinate,
                                                        span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
                            self.mapView.setRegion(region, animated: true);
                        }
                    }
                    
                }
            }
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
