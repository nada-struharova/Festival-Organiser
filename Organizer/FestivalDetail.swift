//
//  FestivalDetail.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct FestivalDetail: View {
    
    @EnvironmentObject private var festivalDB: FestivalDataService
    @EnvironmentObject private var locationManager: LocationManager
    
    @Binding var festival: Festival
    
    @State private(set) var pois: [PointOfInterest]
    @State var selectedPlace: PointOfInterest?
    @State var region: MKCoordinateRegion
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: pois) { poi in
                    MapAnnotation(coordinate: poi.coordinate) {
                        VStack {
                            Image(systemName: PointOfInterest.getIcon(poi: poi))
                                .resizable()
                                .foregroundColor(PointOfInterest.getColor(poi: poi))
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                            
                            Text(poi.name)
                                .fixedSize()
                                .foregroundStyle(.red.gradient)
                                .bold()
                        }
                        .onTapGesture {
                            selectedPlace = poi
                        }
                    }
                }
                .ignoresSafeArea()
                .accentColor(Color(.systemPink))
                //            .onTapGesture {
                //                // TODO: code for adding map annotation on long press
                //                print("tapped")
                //            }
                //            .gesture(DragGesture())
                //            .onLongPressGesture {
                //                print("Here!")
                //            }
                
                Circle()
                    .strokeBorder(Color.red, lineWidth: 4)
                    .background(Circle()
                        .foregroundColor(Color.red))
                    .opacity(0.4)
                    .frame(width: 44, height: 44)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            print("Push festival to database")
                            let driver: DataBaseDriver = PostgreSQLDriver()
                            
                            //let region = locationManager.region
                            
                            festival.centreLat = region.center.latitude
                            festival.centreLong = region.center.longitude
                            festival.height = region.span.latitudeDelta
                            festival.width = region.span.longitudeDelta
                            
                            driver.connect()
                            driver.addFestival(festival: festival)
                            driver.close()
                        }, label: {
                            Text("Publish")
                                .frame(width: 80, height: 30)
                        })
                        .buttonStyle(.borderedProminent)
                        .foregroundColor(.white)
                    }
                }
                
                VStack (alignment: .trailing){
                    
                    Spacer()
                    
                    HStack (alignment: .bottom){
                        LocationButton {
                            locationManager.updateLocation()
                        }
                        .padding()
                        .frame(width: 44, height: 44)
                        .labelStyle(.iconOnly)
                        .symbolVariant(.fill)
                        .foregroundColor(.white)
                        .background(.blue.opacity(0.75))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.trailing)
                    }
                    
                    HStack (alignment: .bottom) {
                        
                        Spacer()
                        
                        Button {
                            //create new POI
                            //let region = locationManager.region
                            
                            let newPoi = PointOfInterest(name: "", type: POIType.Stage, latitude: region.center.latitude, longitude: region.center.longitude)
                            pois.append(newPoi)
                            festival.festivalAddPoi(poi: newPoi)
                            
                            selectedPlace = newPoi
                        } label: {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .frame(width: 44, height: 44)
                        .background(.white.opacity(0.9))
                        .foregroundColor(.blue)
                        .font(.title)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(.trailing)
                    }
                }
            }
            .sheet(item: $selectedPlace) { poi in
                POIEditView(poi: poi) { newPoi in
                    guard let selectedPlace = selectedPlace else { return }
                    
                    if let index = pois.firstIndex(of: selectedPlace) {
                        pois[index] = newPoi
                    }
                    
                    festival.toPOI(pois: pois)
                }
            }
        }
        .navigationTitle(festival.displayName ?? "New Festival")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FestivalDetail_Previews: PreviewProvider {
    static var previews: some View {
        let festival = FestivalDataService.example[0]
        let pois = FestivalDataService.example[0].getPois()
        let region = MapDetails.defaultRegion
                               
        FestivalDetail(festival: .constant(festival),
                       pois: pois,
                       region: region)
            .environmentObject(FestivalDataService())
            .environmentObject(LocationManager())
    }
}
