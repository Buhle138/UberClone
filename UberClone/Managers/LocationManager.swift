//
//  LocationManager.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/04.
//


//WE CAN'T ASK THE USER FOR THEIR CURRENT LOCATION THROUGH THE MAPVIEW FRAMEWORK
// WE HAVE TO USE THIS LOCATION MANAGER. 

import CoreLocation


class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    
//That static keyword allows it to be accessible on other classes!. 
   static let shared = LocationManager() //This static keyword acts like an environment object making this LocationManager() constructor available to be utilised.  on other structs such as your UberMapViewRepresentable
    @Published var userLocation: CLLocationCoordinate2D?
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // this gives the most accurate location of the user
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}


extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
       //if the locations is not empty continue  to the next line of code (locationManager.stopUpdatingLocation() or else exit the functions.
        guard let location = locations.first else {return}
        
        self.userLocation = location.coordinate
        
        locationManager.stopUpdatingLocation()
    }
}
