//
//  DriverAnnotation.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/23.
//

import Foundation

import MapKit
import Firebase


class DriverAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    let uid: String //getting the unique annotations for each driver so we don't get confused.
    
    init(driver: User ) {
        self.coordinate = CLLocationCoordinate2D(
            latitude: driver.coordinates.latitude,
            longitude: driver.coordinates.longitude)
        self.uid = driver.uid
    }
    
}
