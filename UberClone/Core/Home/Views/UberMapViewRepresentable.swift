//
//  UberMapViewRepresentable.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/04.
//

import SwiftUI
import MapKit

//This UIViewRepresentable allows us to create a view using UI Kit and represent that view using swiftui.


// in thie case we are using UIkit mapview  because swiftui does not have those features yet
//UIViewRepresentable allows us to use the UIkit mapKit into our swiftui.


//THE CONTEXT.COORDINATOR ALLOWS US TO GET ACCESS TO METHODS THAT WHERE CREATED THROUGH UIKIT CODE BELOW LIKE GETTING REGIONS


//Don't make any updates of any fields of any class whether it's the view model or whatever, just don't make them
struct UberMapViewRepresentable: UIViewRepresentable  {
    
    let mapView = MKMapView() // this is the UI kit Mapview
    
    let locationManager = LocationManager.shared
    
    @Binding var mapState: MapViewState
    
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    @EnvironmentObject var  homeViewModel: HomeViewModel
    
    
    //Making the Mapkit UI view so that it can be represented in our swiftui view
    
    //we are creating UIKit view within Swiftui context
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
        
        
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            context.coordinator.addDriversToMap(homeViewModel.drivers)
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            //We want to use this selected location on our mapview so that we can generate data
            if let coordinate = locationViewModel.selectedUberLocation?.coordinate {
               
                //REMEMBER coordinator is the bridge between UIKit and Swiftui
                //We use the context to get access to the coordinator
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate) //Adding that red marker onto our mapview
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate) //Adding the polyline using the route. 
            }
            break
        case .polylineAdded:
            break //this break keyword after the switch ensures that we do not keep on adding the polyline after we have added it. 
        }
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self) //Below we are passing in this entire struct into the MapCoordinator.
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
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let annotation = annotation as? DriverAnnotation {
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "driver")
                view.image = UIImage(named: "chevron-sign-to-right")
                return view
            }
            
            return nil 
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
            parent.locationViewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapState = .polylineAdded
                // this line of code below ensures that the mapview is shrunk into a rectangle with those dimensions below
                //note: rect stands for rectangle!
                let rect =  self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                
            }
        }
        
        //with this method below we want to generate a route to be displayed on the map. a route from the users current location to their preferred destination.
       
        
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
        
        func addDriversToMap(_ drivers: [User]) {
            let annotations = drivers.map({DriverAnnotation(driver: $0)})
            self.parent.mapView.addAnnotations(annotations)
        }
        
    }
}
