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
    
    init(uid: String, geoPoint: GeoPoint ) {
        self.coordinate = CLLocationCoordinate2D(
            latitude: geoPoint.latitude,
            longitude: geoPoint.longitude)
        self.uid = uid
    }
    
}
