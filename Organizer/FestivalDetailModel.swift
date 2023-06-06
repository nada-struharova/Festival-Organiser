//
//  FestivalDetailModel.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import Foundation
import CoreLocation

class FestivalDetailModel: ObservableObject {
    
    @Published var festival: Festival = Festival(id: 0,
                                                 displayName: "None",
                                                 centreLat: 0,
                                                 centreLong: 0,
                                                 height: 0,
                                                 width: 0,
                                                 stages: [:])
    
    //calculate centre ?
    
    func addStage(name: String, location: CLLocationCoordinate2D) {
        festival.stages[name] = location
    }
    
}
