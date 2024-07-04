//
//  UberMapViewRepresentable.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/04.
//

import SwiftUI
import MapKit


// in thie case we are using UIkit mapview  because swiftui does not have those features yet
//UIViewRepresentable allows us to use the UIkit mapKit into our swiftui.

struct UberMapViewRepresentable: UIViewRepresentable  {
    
    let mapView = MKMapView()
    
    let locationManager = LocationManager()
    
    func makeUIView(context: Context) -> some UIView {
        mapView.isRotateEnabled  = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    //We are going to use thie function below in order to update our map view. if the user makes changes
    //changes such as changes in their location.
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}

extension UberMapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapViewRepresentable //allows the coordinator to communicate back with the swift ui view.
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        //this mapView method below tells the MKMapViewDelegate that the location was updated
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            
        }
    }
}
