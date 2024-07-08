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
    
    let locationManager = LocationManager.shared
    
    @Binding var mapState: MapViewState
    
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
        
        print("Debug Map State is \(mapState)")
        
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .locationSelected:
            //We want to use this selected location on our mapview so that we can generate data
            if let coordinate = locationViewModel.selectedLocationCoordinate {
                print("DEBUG: Coordinate is \(coordinate)")
                //REMEMBER coordinator is the bridge between UIKit and Swiftui
                //We use the context to get access to the coordinator
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate) //Adding that red marker onto our mapview
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate) //Adding the polyline using the route. 
            }
        case .searchingForLocation:
            break
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
        
        var currentRegion: MKCoordinateRegion?
        
        
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
            
            self.currentRegion = region
            
            //BASCIALLY WE ADDING THIS REGION INSIDE THE UberMapViewRepresentable WHICH IS THE SWIFTUI CODE. SO THAT IT CAN BE DISPLAYED IN OUR SWIFTUI
            parent.mapView.setRegion(region, animated: true)
        }
        
        // MARK: - Helpers
        
       //Drawing the actual polyline onto the Mapview
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
        }
        
        //This is method is for setting up the polyline
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            
            //code below ensures that userLocationCoordinate not null if it is null then the function exits.
            guard let userLocationCoordinate = self.userLocationCoordinate else {return }
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                
                // this line of code below ensures that the mapview is shrunk into a rectangle with those dimensions below
                //note: rect stands for rectangle!
                let rect =  self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                
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
        
        //function below is there to clear the map view when we click on the back button.
        
        func clearMapViewAndRecenterOnUserLocation() {
            //removing all of the over lays and re-center the mapview.
            
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            //this code will clear the mapview when we click on the back button.
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
        
    }
}
