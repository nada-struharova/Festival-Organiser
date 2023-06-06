//
//  Festival.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import Foundation
import CoreLocation

struct Festival: Identifiable {
    let id = UUID()
    var displayName: String?
    var centreLat: Double
    var centreLong: Double
    var height: Double
    var width: Double
    var stages: [String : CLLocationCoordinate2D]
    var toilets: [CLLocationCoordinate2D]?
    var water: [CLLocationCoordinate2D]?
    
}
