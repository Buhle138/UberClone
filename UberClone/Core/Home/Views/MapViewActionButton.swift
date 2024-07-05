//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/05.
//

import SwiftUI

struct MapViewActionButton: View {
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "line.3.horizontal")
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
        MapViewActionButton()
    }
}
