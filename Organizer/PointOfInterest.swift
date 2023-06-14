//
//  PointOfInterest.swift
//  Organizer
//
//  Created by Nada Struharova on 6/7/23.
//

import Foundation
import CoreLocation
import SwiftUI

struct PointOfInterest: Identifiable, Equatable, Codable {
    var id = UUID()
    var name: String
    var type: POIType = POIType.Other
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: PointOfInterest, rhs: PointOfInterest) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func getIcon(poi: PointOfInterest) -> String {
        switch poi.type {
        case POIType.Stage:
            return "music.mic.circle.fill"
        case POIType.Toilet:
            return "toilet.circle.fill"
        case POIType.Water:
            return "drop.circle.fill"
        default:
            return "mappin.circle.fill"
        }
    }
    
    static func getColor(poi: PointOfInterest) -> Color {
        // TODO: Use Colors from user app
        switch poi.type {
        case POIType.Stage:
            return Color.red
        case POIType.Toilet:
            return Color.black
        case POIType.Water:
            return Color.blue
        default:
            return Color.purple
        }
    }
    
    static let example = PointOfInterest(name: "O2 Stage",type: POIType.Stage, latitude: 51.501, longitude: -0.141)
    
}

enum POIType: Int, Codable {
    case Stage  // encoded to 0
    case Toilet // encoded to 1
    case Water  // encoded to 2
    case Other  // encoded to 3
}
