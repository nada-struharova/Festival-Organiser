//
//  FestivalDetail.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import SwiftUI
import MapKit

struct FestivalDetail: View {
    
    @State var festival: Festival
    
    @EnvironmentObject private var festivalDB: FestivalDataService
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.pois) { poi in
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
                        viewModel.selectedPlace = poi
                    }
                }
                
            }
                .ignoresSafeArea()
                .accentColor(Color(.systemPink))
                .onAppear {
                    viewModel.checkLocationServices()
                }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        //create new POI
                        viewModel.addPoi()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .sheet(item: $viewModel.selectedPlace) { poi in
            POIEditView(poi: poi) { newPoi in
                viewModel.updatePoi(updatedPoi: newPoi)
                // save()
                    // loads data to database through viewModel
            }
            
        }
    }
}

struct FestivalDetail_Previews: PreviewProvider {
    static var previews: some View {
        // pass info of selected festival
        FestivalDetail(festival: FestivalDataService().festivals[0])
            .environmentObject(FestivalDataService().festivals[0])
    }
}
