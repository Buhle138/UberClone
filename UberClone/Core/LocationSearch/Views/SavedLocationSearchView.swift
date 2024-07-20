//
//  SavedLocationSearchView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/17.
//

import SwiftUI

struct SavedLocationSearchView: View {
    
    @State private var text = ""
    @StateObject var locationSearchViewModel = LocationSearchViewModel()
    let config: SavedLocationViewModel //We are initialising this variable so that we can know if we are saving this location as a home location or a work location.
    
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .imageScale(.medium)
                    .padding(.leading) //adding padding on the image from the right. 
                
                TextField("Search for a location..", text: $locationSearchViewModel.queryFragment)
                    .frame(height: 32)
                    .padding(.leading) //giving the 'Search for a location' text padding.
                    .background(Color(.systemGray5))
                    .padding(.trailing)
            }
            .padding(.top)
            Spacer()
            
            LocationSearchResultsView(viewModel: locationSearchViewModel, config: .saveLocation(config))
        }
        .navigationTitle(config.subtitle)
    }
}

struct SavedLocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SavedLocationSearchView(config: .home)
        }
       
    }
}
