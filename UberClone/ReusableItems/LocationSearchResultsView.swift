//
//  LocationSearchResultsView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/17.
//

import SwiftUI

struct LocationSearchResultsView: View {
    
    //Below we are using the stateObject because if we use an environment object all of those researches we made on the home view will be made remain on this page. in other words we will be using the same view model in different places and we don't want to do that. (remember we used this view model in the Home view as an environment Object).
    @StateObject var viewModel: LocationSearchViewModel
    let config: LocationResultsViewConfig
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                ForEach(viewModel.results, id: \.self) { result in
                    //when we tap on each of  locationSearchResultCell we want to dispmiss the showLocationSearchView.
                    LocationSearchResultsCell(title: result.title, subtitle: result.subtitle)
                        .onTapGesture {
                            
                            //we'll get an animation when we call the ride request view
                            withAnimation(.spring()) {
                                
                                //Selecting the location the user has clicked on
                                //we are passing in the title which we will then use in our mapview representable so that we can use it to show it to the mapview representable.
                                viewModel.selectedLocation(result, config: config)
                                //mapState = .locationSelected //once we tap on any location the state now will be locationSelected.
                                
                            }
                            
                        }
                }
            }
        }
    }
}


