//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/05.
//

import SwiftUI

struct MapViewActionButton: View {
    
    //SINCE THERE IS BINDING HERE THIS VARIABLE WILL CHANGE VALUE OF THE SHOWLOCATIONSEARCH VARIABLE INSIDE OF THE HOMEVIEW
    @Binding var showLocationSearchView: Bool
    var body: some View {
        Button {
            withAnimation (.spring()){
                showLocationSearchView.toggle()
            }
        } label: {
            Image(systemName: showLocationSearchView ? "arrow.left" : "line.3.horizontal")
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
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(showLocationSearchView: .constant(true))
    }
}
