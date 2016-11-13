//
//  Locations.swift
//  EcoKitcheniOS
//
//  Created by mh53653 on 11/13/16.
//  Copyright © 2016 madan. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let address : String
    let description : String
    let status : Bool
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
}
