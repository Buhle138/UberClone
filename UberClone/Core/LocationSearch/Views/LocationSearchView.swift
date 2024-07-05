//
//  LocationSearchView.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/05.
//
import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationText = ""
    @Binding var showLocationSearchView: Bool
    @EnvironmentObject var viewModel :  LocationSearchViewModel
    
    var body: some View {
        VStack {
            //header view
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                //VStack for our textfields
                VStack {
                    TextField("Current location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(
                            .systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            
            Divider()
                .padding(.vertical)
            
          
            //list view
            
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(viewModel.results, id: \.self) { result in
                        //when we tap on each of  locationSearchResultCell we want to dispmiss the showLocationSearchView.
                        LocationSearchResultsCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                //Selecting the location the user has clicked on
                                //we are passing in the title which we will then use in our mapview representable so that we can use it to show it to the mapview representable.
                                viewModel.selectedLocation(result)
                                showLocationSearchView.toggle()
                                
                               
                            }
                    }
                }
            }
        }
        
        .background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(showLocationSearchView: .constant(false))
    }
}
