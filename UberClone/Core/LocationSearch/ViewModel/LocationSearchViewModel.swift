//
//  LocationSearchViewModel.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/05.
//

import Foundation
import MapKit


class LocationSearchViewModel: NSObject, ObservableObject {
    
    
    //Make: -Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    
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
    
    
    //The  purpose of this function is to select the location which the user has selected. 
    func selectedLocation(_ localSearch: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
    
            //THE CODE THAT WE ARE WRITTING HERE IS THE CODE OF THE COMPLETION HANLDER
            //IF THERE IS AN ERROR WE HANLDE THE ERROR BUT IF THERE IS NO ERROR THEN WE GET THE COORDINATES (LONGITUDES AND LATITUDES)
            if let error = error {
                print("DEVUG: Location search failed with error \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else {return}
            
            let coordinate = item.placemark.coordinate
            
            self.selectedLocationCoordinate = coordinate
            
            print("Debug: Location coordinates \(coordinate)")
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
    func computeRidePrice(forType type: RideType) -> Double {
        guard let destinationCoordinate = selectedLocationCoordinate else { return 0.0 }
        
        guard let userCoordinate = self.userLocation else { return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        
        let destination = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        
        return type.computePrice(for: tripDistanceInMeters)
    }
    
}


extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
