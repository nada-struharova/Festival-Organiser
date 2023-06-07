//
//  ContentView.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//
import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        VStack {
            FestivalList()
            Button("+ Add Festival") {
                let driver: DataBaseDriver = PostgreSQLDriver()
                driver.connect()
                driver.addFestival(festival: Festival(id: 1,
                                            displayName: "Jake Town",
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
                                               CLLocationCoordinate2D(latitude: 51.520628, longitude: -0.101600)])
)
                driver.close()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .body.environmentObject(FestivalDataService())
    }
}

