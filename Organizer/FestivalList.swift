//
//  FestivalList.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct FestivalList: View {
    
    @EnvironmentObject var festivalDB: FestivalDataService
    @StateObject var locationManager = LocationManager()
    
    @State var newName: String = ""
    @State var addingFestival = false
    
    var body : some View {
        VStack {
            NavigationStack {
                VStack {
                    // TODO: change to festivalDB.festivals
                    List(festivalDB.festivals,  id: \.id) { fest in
                        let index = festivalDB.festivals.firstIndex(where: { $0.id == fest.id })!
                        
                        NavigationLink {
                            FestivalDetail(
                                festival: $festivalDB.festivals[index],
                                pois: fest.getPois(),
                                region: fest.getRegion()
                            )
                        } label: {
                            FestivalRow(festival: fest)
                        }
                    }
                    
                    HStack {
                        Spacer()
                        
                        TextField("Enter new festival name...", text: $newName)
                            .textFieldStyle(.roundedBorder)
                        
                        Spacer()
                    }
                    
                    Button("Add Festival") {
                        addingFestival = true
                        // TODO: centre new festival at user location
                        let newFestival = Festival(id: festivalDB.festivals.count + 1,
                                                   displayName: newName,
                                                   centreLat: 51.509865,
                                                   centreLong: 0.118092,
                                                   height: 25,
                                                   width: 25,
                                                   stages: [:])
                        
                        festivalDB.festivals.append(newFestival)
                    }
                    .buttonStyle(.borderedProminent)
                    .navigationDestination(isPresented: $addingFestival) {
                        FestivalDetail(
                            festival: $festivalDB.festivals.last!,
                            pois: festivalDB.festivals.last!.getPois(),
                            region: locationManager.region)
                    }
                    
                }
                .navigationTitle("Your Festivals")
            }
            .environmentObject(festivalDB)
            .environmentObject(locationManager)
        }
    }
    
}

struct FestivalList_Previews: PreviewProvider {
    static var previews: some View {
        FestivalList()
            .environmentObject(FestivalDataService())
            .environmentObject(LocationManager())
    }
}
