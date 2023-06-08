//
//  Festival.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import Foundation
import CoreLocation

struct Festival: Identifiable {
    var id: Int
    var displayName: String?
    var centreLat: Double
    var centreLong: Double
    var height: Double
    var width: Double
    var stages: [String : CLLocationCoordinate2D]
    var toilets: [CLLocationCoordinate2D]?
    var waters: [CLLocationCoordinate2D]?
    
    func centreCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: centreLat, longitude: centreLong)
    }
    
    func getPois() -> [PointOfInterest] {
        // map festival points of interest to map annotations
        
        var pois: [PointOfInterest] = []
        
        stages.forEach { name, coord in
            pois.append(PointOfInterest(name: name, type: POIType.Stage, latitude: coord.latitude, longitude: coord.longitude))
        }
        
        if let toilets = toilets {
            toilets.forEach { coord in
                pois.append(PointOfInterest(name: "WC", type: POIType.Toilet, latitude: coord.latitude, longitude: coord.longitude))
            }
        }
        
        if let waters = waters{
            waters.forEach { coord in
                pois.append(PointOfInterest(name: "Water", type: POIType.Water, latitude: coord.latitude, longitude: coord.longitude))
            }
        }
        
        return pois
    }
    
    mutating func toPOI(pois: [PointOfInterest]) {
        stages = [:]
        toilets = []
        waters = []
        
        pois.forEach { poi in
            switch poi.type {
                
            case .Stage:
                stages[poi.name] = poi.coordinate
            case .Toilet:
                toilets?.append(poi.coordinate)
            case .Water:
                waters?.append(poi.coordinate)
            case .Other:
                print("Unidentified POI.")
            }
        }
    }
    
    mutating func festivalAddPoi(poi: PointOfInterest) {
        switch poi.type {
            
        case .Stage:
            stages[poi.name] = poi.coordinate
        case .Toilet:
            toilets?.append(poi.coordinate)
        case .Water:
            waters?.append(poi.coordinate)
        case .Other:
            print("POI with unknown type.")
        }
    }
}
