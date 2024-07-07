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
    
    var body: some View {
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
            
            if mapState == .locationSelected {
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
