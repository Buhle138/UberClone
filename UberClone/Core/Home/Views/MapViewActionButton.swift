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
        case .noInput: print("Debug: no input")
        case .searchingForLocation: mapState = .noInput
        case .locationSelected:
        print("Debug Clear map View")
        
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput: return "line.3.horizontal"
        case .searchingForLocation, .locationSelected:
       return "arrow.left"
        
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput))
    }
}
