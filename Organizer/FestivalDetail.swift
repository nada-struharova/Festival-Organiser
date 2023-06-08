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
    @EnvironmentObject private var mapView: MapView
    
    @Binding var festival: Festival
    
    @State private(set) var pois = [PointOfInterest]()
    @State var selectedPlace: PointOfInterest?
    @State var region: MKCoordinateRegion
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: pois) { poi in
                MapAnnotation(coordinate: poi.coordinate) {
                    VStack {
                        Image(systemName: PointOfInterest.getIcon(poi: poi))
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                        
                        Text(poi.name)
                            .fixedSize()
                    }
                    .onTapGesture {
                        selectedPlace = poi
                    }
                }
                
            }
            .ignoresSafeArea()
            .accentColor(Color(.systemPink))
            // TODO: sort out user location
//            .onAppear {
//                mapView.checkLocationServices()
//            }
            
            LocationButton(.currentLocation) {
                print("Re-center to current user locaiton.")
            }
            .foregroundColor(.white)
            .cornerRadius(8)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        //create new POI
                        let newPoi = PointOfInterest(name: "", type: POIType.Stage, latitude: region.center.latitude, longitude: region.center.longitude)
                        pois.append(newPoi)
                        festival.festivalAddPoi(poi: newPoi)
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .frame(width: 44, height: 44)
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
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
}

struct FestivalDetail_Previews: PreviewProvider {
    static var previews: some View {
        let festival = FestivalDataService.example[0]
        let pois = FestivalDataService.example[0].getPois()
        let region = MKCoordinateRegion(center: FestivalDataService.example[0].centreCoordinate(), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.04))
                               
                               
        FestivalDetail(festival: .constant(festival), pois: pois, region: region)
            .environmentObject(FestivalDataService())
    }
}
