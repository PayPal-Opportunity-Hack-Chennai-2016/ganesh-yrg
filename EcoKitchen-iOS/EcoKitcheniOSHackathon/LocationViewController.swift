//
//  LocationViewController.swift
//  EcoKitcheniOSHackathon
//
//  Created by mh53653 on 11/12/16.
//  Copyright © 2016 madan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate{

   // @IBOutlet weak var latLongLabel: UILabel!
    @IBOutlet weak var addressLabel: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager : CLLocationManager!
    var lat : CLLocationDegrees = 0.0
    var long : CLLocationDegrees = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad();
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LocationViewController.updateMapCoordinates));
        self.mapView.addGestureRecognizer(tap);
        self.mapView.showsUserLocation = true;
        self.mapView.isZoomEnabled = true;
        self.mapView.isScrollEnabled = true;
        self.navigationItem.title = "Location Referal"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refer", style: .plain, target: self, action: #selector(LocationViewController.referBtnPressed))
        
        self.addressLabel.sizeToFit()
        self.addressLabel.scrollsToTop = true
              //  let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        //self.mapView.setRegion(region, animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapView.setRegion(region, animated: true);
        //latLongLabel.text = "Latitude: \(location.coordinate.latitude) Longitude:\(location.coordinate.longitude)"
        lat = location.coordinate.latitude
        long = location.coordinate.longitude
        
        locationManager.stopUpdatingLocation()
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = (placemarks?[0])! as CLPlacemark
                var addressString = ""
                if (pm.locality != nil) {
                    addressString = addressString + pm.locality!;
                }
                if (pm.subLocality != nil) {
                    addressString = addressString + pm.subLocality!;
                }
                if (pm.country != nil) {
                    addressString = addressString + pm.country!;
                }
                if (pm.administrativeArea != nil) {
                    addressString = addressString + pm.administrativeArea!;
                }
                if (pm.subAdministrativeArea != nil) {
                    addressString = addressString + pm.subAdministrativeArea!;
                }
                if (pm.postalCode != nil) {
                    addressString = addressString + pm.postalCode!;
                }
                if (pm.thoroughfare != nil) {
                    addressString = addressString + pm.thoroughfare!;
                }
                if (pm.subThoroughfare != nil) {
                    addressString = addressString + pm.subThoroughfare!;
                }
                if (pm.name != nil) {
                    addressString = addressString + pm.name!;
                }
                
                self.addressLabel.text = addressString;
                self.addressLabel.sizeToFit()
//                print(pm.locality)
//                print(pm.subLocality)
//                print(pm.country)
//                print(pm.administrativeArea)
//                print(pm.subAdministrativeArea)
//                print(pm.postalCode)
//                print(pm.areasOfInterest)
//                print(pm.thoroughfare)
//                print(pm.subThoroughfare)
//                print(pm.name)
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
        //dropAnnotation(location: location);
    }
    
    func dropAnnotation(location : CLLocation){
        let annotation = MKPointAnnotation()
//        let location = CLLocationCoordinate2D(
//            latitude: 12.909641,
//            longitude: 80.226887
//        )
        annotation.coordinate = CLLocationCoordinate2D.init(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) //location
        annotation.title = "Paypal development chennai"
        annotation.subtitle = "Chennai"
        self.mapView.addAnnotation(annotation)
    }
    
    
    func referBtnPressed(){
        let serviceManager = ServiceManager()
        let location = Location(address: addressLabel.text, description: "Vendor is available", status: true, latitude: lat, longitude: long)
        serviceManager.updateLocation(location: location)
    }
    
    func updateMapCoordinates(gestureReconizer : UILongPressGestureRecognizer) {
        
        if addressLabel.isFirstResponder {
            addressLabel.resignFirstResponder()
            return
        }
        
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
       // latLongLabel.text = "Latitude: \(coordinate.latitude) Longitude:\(coordinate.longitude)"
        lat = coordinate.latitude
        long = coordinate.longitude
        let locationConvert = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude);
        
        CLGeocoder().reverseGeocodeLocation(locationConvert, completionHandler: {(placemarks, error) -> Void in
            print(location)
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                
                    let pm = (placemarks?[0])! as CLPlacemark
                    var addressString = ""
                    if (pm.locality != nil) {
                        addressString = addressString + pm.locality!;
                    }
                    if (pm.subLocality != nil) {
                        addressString = addressString + pm.subLocality!;
                    }
                    if (pm.country != nil) {
                        addressString = addressString + pm.country!;
                    }
                    if (pm.administrativeArea != nil) {
                        addressString = addressString + pm.administrativeArea!;
                    }
                    if (pm.subAdministrativeArea != nil) {
                        addressString = addressString + pm.subAdministrativeArea!;
                    }
                    if (pm.postalCode != nil) {
                        addressString = addressString + pm.postalCode!;
                    }
                    if (pm.thoroughfare != nil) {
                        addressString = addressString + pm.thoroughfare!;
                    }
                    if (pm.subThoroughfare != nil) {
                        addressString = addressString + pm.subThoroughfare!;
                    }
                    if (pm.name != nil) {
                        addressString = addressString + pm.name!;
                    }
                    
                    self.addressLabel.text = addressString;
          //      CGRect frame = self.addressLabel.frame;
        
                   // frame.size = self.addressLabel.contentSize;
                  //  self.addressLabel.frame = frame;

                    self.addressLabel.sizeToFit()
                self.addressLabel.scrollsToTop = true
              //  self.addressLabel.frame.height = self.addressLabel.contentSize.height
                    //                print(pm.locality)
                    //                print(pm.subLocality)
                    //                print(pm.country)
                    //                print(pm.administrativeArea)
                    //                print(pm.subAdministrativeArea)
                    //                print(pm.postalCode)
                    //                print(pm.areasOfInterest)
                    //                print(pm.thoroughfare)
                    //                print(pm.subThoroughfare)
                    //                print(pm.name)
                
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })

    }
}
