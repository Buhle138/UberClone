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
    
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled  = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    //We are going to use thie function below in order to update our map view. if the user makes changes
    //changes such as changes in their location.
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let selectedLocation = locationViewModel.selectedLocation {
            print("Debug: Selected location in map view \(selectedLocation)")
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
    
}


// All of this code inside of UberMapViewRepresentable represents Swiftui code
//All of this code inside of MapCoordinator is UIkit code
// Then the MapCoordinator acts as a bridge between the UIkit code and the swiftui code.
extension UberMapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapViewRepresentable //allows the coordinator to communicate back with the swift ui view.
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        //this mapView method below tells the MKMapViewDelegate that the location was updated
        //so we want to gain access to that userLocation parameter and create a region on our mapview so that we can zoom in on that region and display the users location.
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // the span is the zoom
            )
    
            //BASCIALLY WE ADDING THIS REGION INSIDE THE UberMapViewRepresentable WHICH IS THE SWIFTUI CODE. SO THAT IT CAN BE DISPLAYED IN OUR SWIFTUI
            parent.mapView.setRegion(region, animated: true)
        }
    }
}
