//
//  FestivalDataService.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import Foundation
import MapKit

class FestivalDataService : ObservableObject {
    
    @Published var festivals: [Festival] = [
        Festival(id: 1,
                 displayName: "Leeds",
                 centreLat: 51.520627,
                 centreLong: -0.101602,
                 height: 10,
                 width: 12,
                 stages: ["Stage 1" : CLLocationCoordinate2D(latitude: 51.520624, longitude: -0.101602),
                          "Stage 2" : CLLocationCoordinate2D(latitude: 51.520619, longitude: -0.101609)],
                 toilets: [
                    CLLocationCoordinate2D(latitude: 51.520625, longitude: -0.101604),
                    CLLocationCoordinate2D(latitude: 51.520628, longitude: -0.101600)
                 ],
                 waters: [
                    CLLocationCoordinate2D(latitude: 51.520625, longitude: -0.101604),
                    CLLocationCoordinate2D(latitude: 51.520628, longitude: -0.101600)]),
        Festival(id: 2,
                 displayName: "Reading",
                 centreLat: 51.464487,
                 centreLong:  -0.984981,
                 height: 10, width: 12,
                 stages: ["O2 Stage" : CLLocationCoordinate2D(latitude: 51.464490, longitude: -0.984980),
                          "RedBull Stage" : CLLocationCoordinate2D(latitude: 51.464479, longitude: -0.984977)],
                toilets: [CLLocationCoordinate2D(latitude: 51.464475, longitude: -0.984975),
                          CLLocationCoordinate2D(latitude: 51.464469, longitude: -0.984982)],
                waters: [])
        ]
    
    // pull real data from Postgres
}
