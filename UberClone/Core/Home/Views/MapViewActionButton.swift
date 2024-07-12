//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/05.
//

import SwiftUI

struct MapViewActionButton: View {
    
    //SINCE THERE IS BINDING HERE THIS VARIABLE WILL CHANGE VALUE OF THE SHOWLOCATIONSEARCH VARIABLE INSIDE OF THE HOMEVIEW
    @Binding var mapState: MapViewState
    
    //we are using this view model so that we can set the selectedLocationCoordinates to null after selecting a location. To avoid getting multiple polylines on the map
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Button {
            withAnimation (.spring()){
                actionforState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        //aligning this to the leading edge
        .frame(maxWidth: .infinity, alignment: .leading)

    }
    
    func actionforState(_ state: MapViewState) {
        switch state {
        case .noInput: authViewModel.signout()
        case .searchingForLocation: mapState = .noInput
        case .locationSelected, .polylineAdded:
            //this is for when the user has selected a location we'll change the mapstate to no input. 
            mapState = .noInput
            
            //making sure that the selectedLocationCoordinate is null so that we don't have multiple Polylines onto the screen. 
            viewModel.selectedUberLocation = nil
        
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput: return "line.3.horizontal"
        case .searchingForLocation, .locationSelected, .polylineAdded:
            return "arrow.left"
        default: return "line.3.horizontal"
        
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput))

    }
}
