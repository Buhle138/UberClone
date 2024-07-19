//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/05.
//

import Foundation
import MapKit
import Firebase


//we need to know whether we are looking to save a location or we are looking for a ride.
enum LocationResultsViewConfig {
    case ride
    case saveLocation (SavedLocationViewModel)
    
}

class LocationSearchViewModel: NSObject, ObservableObject {

    //Make: -Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    
    @Published var selectedUberLocation: UberLocation?
    
    @Published var pickUpTime: String?
    
    @Published var dropOffTime: String? 
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    //this query will be made by the user to search for their location
    //the searchCompleter will receive this query and return the results from the completer variable inside of the parameters of the completerDidUpdateResults method in your extension
    //we then asign those results inside the  results @Published field.
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //Make: -Helpers
    
    //This function below is called when we select a location.
    //The  purpose of this function is to select the location which the user has selected. 
    func selectedLocation(_ localSearch: MKLocalSearchCompletion, config: LocationResultsViewConfig) {
        
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            
         
                //THE CODE THAT WE ARE WRITTING HERE IS THE CODE OF THE COMPLETION HANLDER
                //IF THERE IS AN ERROR WE HANLDE THE ERROR BUT IF THERE IS NO ERROR THEN WE GET THE COORDINATES (LONGITUDES AND LATITUDES)
                if let error = error {
                    print("DEVUG: Location search failed with error \(error.localizedDescription)")
                    return
                }
                guard let item = response?.mapItems.first else {return}
                
                let coordinate = item.placemark.coordinate
            
            switch config {
            case .ride:
                self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
            case .saveLocation(let viewModel):
                
                //getting the uid of the current user so that we know which user this saved location belongs to.
                guard let uid = Auth.auth().currentUser?.uid else { return }
                
                let savedLocation = SavedLocation(
                    title: localSearch.title,
                    address: localSearch.subtitle,
                    coordinates: GeoPoint(latitude: coordinate.latitude, longitude: coordinate.longitude))
                
                //Encoding the object so that it can be uploaded to firestore
                guard let encodedLocation = try? Firestore.Encoder().encode(savedLocation) else { return }
                Firestore.firestore().collection("users").document(uid).updateData([
                    viewModel.databaseKey : encodedLocation
                ])
            }
            
        }
        
       
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler ){
        
        let searchRequest = MKLocalSearch.Request()
        
        
        //naturalLanguageQuery is the full address that we are searching for.
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
        
    }
    
    
    //calculating the price of the ride depending on the type of the ride (uber-x, uber-Large)
    //In this function we are getting the trip distance and passing it into the computePrice method
    func computeRidePrice(forType type: RideType) -> Double {
        guard let destinationCoordinate = selectedUberLocation?.coordinate else { return 0.0 }
        
        guard let userCoordinate = self.userLocation else { return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        
        let destination = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        
        return type.computePrice(for: tripDistanceInMeters)
    }
    
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
            self.configurePickupAndDropOffTimes(with: route.expectedTravelTime)
            completion(route)
        }
    }
    
    func configurePickupAndDropOffTimes (with expectedTravelTime: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        pickUpTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
    }
}


extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
