//
//  FestivalList.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct FestivalList: View {
    
    @EnvironmentObject private var festivalDB: FestivalDataService
    
    @EnvironmentObject private var mapView: MapView
    
    @State var newName: String = ""
    
    var body : some View {
        VStack {
            NavigationStack {
                // TODO: change to festivalDB.festivals
                List(festivalDB.festivals,  id: \.id) { fest in
                    let index = festivalDB.festivals.firstIndex(where: { $0.id == fest.id })!
                    NavigationLink {
                        FestivalDetail(festival: $festivalDB.festivals[index], pois: fest.getPois(), region: MKCoordinateRegion(center: fest.centreCoordinate(), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.04)))
                    } label: {
                        FestivalRow(festival: fest)
                    }
                }
                .navigationTitle("Your Festivals")
                
                HStack {
                    Spacer()
                    
                    TextField("Enter new festival name...", text: $newName)
                        .textFieldStyle(.roundedBorder)
                    
                    Spacer()
                }
                
                Button("Add Festival") {
                    // TODO: centre new festival at user location
                    
                    //TODO: add festival with correct ID, centre and dimensions
                    festivalDB.festivals.append(
                        Festival(id: festivalDB.festivals.count + 1,
                                 displayName: newName,
                                 centreLat: mapView.locationManager?.location!.coordinate.latitude ?? 51.509865,
                                 centreLong: mapView.locationManager?.location!.coordinate.longitude ?? 0.118092,
                                 height: 25,
                                 width: 25,
                                 stages: [:]))
                }
                .buttonStyle(.borderedProminent)
            }
            .environmentObject(festivalDB)
        }
    }
    
}

struct FestivalList_Previews: PreviewProvider {
    static var previews: some View {
        FestivalList()
            .environmentObject(FestivalDataService())
            .environmentObject(MapView())
    }
}
