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
    let config: SavedLocationViewModel
    
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .imageScale(.medium)
                    .padding(.leading)
                
                TextField("Search for a location..", text: $locationSearchViewModel.queryFragment)
                    .frame(height: 32)
                    .padding(.leading)
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
