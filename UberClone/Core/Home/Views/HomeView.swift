//
//  HomeView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/04.
//

import SwiftUI

struct HomeView: View {
    
    //THIS VARIABLE VALUE DEPENDS ON THE BINDING VARIABLE OF THE MAPVIEW ACTION BUTTON.
    @State private var mapState = MapViewState.noInput
    
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        Group {
            
            //if there is not user currently loggin in the show the login screen.
            if authViewModel.userSession == nil {
                LoginView()
            }else {
                ZStack(alignment: .bottom) { //This z Stack is where we are going to present this ride request view.
                    ZStack(alignment: .top) {
                        UberMapViewRepresentable(mapState: $mapState)
                            .ignoresSafeArea()
                        
                        if mapState == .searchingForLocation {
                            LocationSearchView(mapState: $mapState)
                        }else if mapState == .noInput{
                            LocationSearchActivationView()
                                .padding(.top, 72)
                                .onTapGesture {
                                    withAnimation (.spring()){
                                        mapState = .searchingForLocation
                                    }
                                }
                        }
                        
                        MapViewActionButton(mapState: $mapState)
                            .padding(.leading)
                            .padding(.top, 4)
                    }
                    
                    if mapState == .locationSelected || mapState == .polylineAdded   {
                        RideRequestView()
                            .transition(.move(edge: .bottom))
                    }
                }
                .edgesIgnoringSafeArea(.bottom) // removing that spacing below the the ride view
                .onReceive(LocationManager.shared.$userLocation) { location in
                    
                    //getting the user location on our home view
                    if let location = location {
                        locationViewModel.userLocation = location
                    }
                }
            }
            
       
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
