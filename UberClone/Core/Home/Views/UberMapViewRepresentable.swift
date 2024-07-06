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
    
    //We are going to use thie function below in order to update our map view (in swiftui). if the user makes changes
    //changes such as changes in their location through coordinates.
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        //We want to use this selected location on our mapview so that we can generate data
        if let coordinate = locationViewModel.selectedLocationCoordinate {
            //REMEMBER coordinator is the bridge between UIKit and Swiftui
            //We use the context to get access to the coordinator
            context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
            context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
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
        
        //Make: -properties
        
        
        
        let parent: UberMapViewRepresentable //allows the coordinator to communicate back with the swift ui view.
        var userLocationCoordinate: CLLocationCoordinate2D?
        
        
        //Make: -Lifecycle
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        //Mark: -MKMapViewDelegate
        
        //this mapView method below tells the MKMapViewDelegate that the location was updated
        //so we want to gain access to that userLocation parameter and create a region on our mapview so that we can zoom in on that region and display the users location.
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            
            //note that mapView has the userLocation coordinates so we'll pass those coordinates into that empty field of userLocationCoordinate.
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // the span is the zoom
            )
            
            
            //BASCIALLY WE ADDING THIS REGION INSIDE THE UberMapViewRepresentable WHICH IS THE SWIFTUI CODE. SO THAT IT CAN BE DISPLAYED IN OUR SWIFTUI
            parent.mapView.setRegion(region, animated: true)
        }
        
        // MARK: - Helpers
        
       //Drawing the actual route onto the Mapview
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            
            return polyline
        }
        
        //This method helps us get the marker that marks the location onto our map.
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            //we are using this line of code below in order to ensure that we only have one marker for each search we don't want the markers to remain onto the mapview. that's why we say removeAnnotations.
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            self.parent.mapView.addAnnotation(anno)
            self.parent.mapView.selectAnnotation(anno, animated: true)
            
            //This line of code below allows the mapview to automatically zoom out in order to adjust to the location that is far away.
            self.parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        //This is method is for setting up the polyline
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            
            guard let userLocationCoordinate = self.userLocationCoordinate else {return }
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
            
            }
        }
        
        //with this method below we want to generate a route to be displayed on the map. a route from the users current location to their preferred destination.
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destinationPlacemark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destinationPlacemark)
            let directions = MKDirections(request: request)
            
            directions.calculate { response, error in
                if let error = error {
                    print("Failed to get directions with error \(error.localizedDescription)")
                    return
                }
                
                //we will be given three potential routes what we want is the first one because it's the fastest route.
                guard let route = response?.routes.first else {return}
                
                completion(route)
            }
        }
    }
}