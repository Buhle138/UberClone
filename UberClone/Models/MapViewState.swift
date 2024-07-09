//
//  MapViewState.swift
//  UberClone
//
//  Created by Buhle Radzilani on 2024/07/06.

import Foundation

enum MapViewState {
    case noInput
    case locationSelected
    case searchingForLocation
    case polylineAdded //This polylineAdded notifies the mapview that the polyline  has been added there is no need to keep on calling the poly line.
}
