//
//  ViewController.swift
//  UserLocationMapKit
//
//  Created by Apple on 04/03/18.
//  Copyright © 2018 vicky. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class GetUserLocationVC: UIViewController, CLLocationManagerDelegate{

    // Outlets:
    @IBOutlet weak var mapView: MKMapView!
    
    // Variables:
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocationManager()
    }

    func setLocationManager() {
        
        mapView.showsUserLocation = true
        mapView.showsTraffic = true
        mapView.showsBuildings = true
        
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.authorizationStatus() == .restricted ||
                CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined {
                
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            print(" Please turn on your location services")
        }
    }
    
    // CLLocationManagerDelegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(locations[0].coordinate.latitude, locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        self.mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(" Failed : Unable to access your current location.")
    }
    
    

}

