//
//  Festival.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import Foundation
import CoreLocation

<<<<<<< HEAD:Organizer/Festival.swift
struct Festival: Identifiable {
    var id: Int
    var displayName: String
=======
struct Festival {
    let id: Int
    var displayName: String?
>>>>>>> postgresDriver:Festival.swift
    var centreLat: Double
    var centreLong: Double
    var height: Double
    var width: Double
    var stages: [String : CLLocationCoordinate2D]
    var toilets: [CLLocationCoordinate2D]?
    var waters: [CLLocationCoordinate2D]?
<<<<<<< HEAD:Organizer/Festival.swift
=======
    
>>>>>>> postgresDriver:Festival.swift
}
