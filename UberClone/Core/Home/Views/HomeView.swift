//
//  HomeView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/04.
//

import SwiftUI

struct HomeView: View {
    
    //THIS VARIABLE VALUE DEPENDS ON THE BINDING VARIABLE OF THE MAPVIEW ACTION BUTTON.
    @State private var showLocationSearchView = false
    
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            
            if showLocationSearchView {
                LocationSearchView(showLocationSearchView: $showLocationSearchView)
            }else {
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation (.spring()){
                            showLocationSearchView.toggle()
                        }
                    }
            }
            
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
