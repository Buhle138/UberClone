//
//  SavedLocationSearchView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/17.
//

import SwiftUI

struct SavedLocationSearchView: View {
    
    @State private var text = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .imageScale(.medium)
                
                TextField("Search for a location..", text: $text)
            }
        }
        .navigationTitle("Add Home")
    }
}

struct SavedLocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SavedLocationSearchView()
        }
       
    }
}
