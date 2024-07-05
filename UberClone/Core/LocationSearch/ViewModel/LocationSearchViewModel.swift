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
    
    @Published var selectedLocation: String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    //this query will be made by the user to search for their location
    //the searchCompleter will receive this query and return the results from the completer variable inside of the parameters of the completerDidUpdateResults method in your extension
    //we then asign those results inside the  results @Published field.
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //Make: -Helpers
    
    
    //The  purpose of this function is to select the location which the user has selected. 
    func selectedLocation(_ location: String) {
        self.selectedLocation = location
        print("Debug: Selected location is \(self.selectedLocation)")
    }
}


extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
