//
//  FestivalDetail.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import SwiftUI
import MapKit

<<<<<<< HEAD
struct FestivalDetail: View {
    
    var festival: Festival
    
    @EnvironmentObject private var detailModel: FestivalDetailModel
    
=======
struct FestivalDetail {
    
    @EnvironmentObject private var vm: FestivalDetailModel
>>>>>>> postgresDriver
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.520627,
                                       longitude: -0.101602),
        span: MKCoordinateSpan(latitudeDelta: 0.03,
                               longitudeDelta: 0.04))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
<<<<<<< HEAD
                .onAppear {
                    setRegion(CLLocationCoordinate2D(latitude: festival.centreLat, longitude: festival.centreLong))
                }
        }
    }
    
    func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.04))
    }
}

struct FestivalView_Previews: PreviewProvider {
    static var previews: some View {
        FestivalDetail(festival: FestivalDataService().festivals[1])
=======
        }
    }
}

struct FestivalDetail_Previews: PreviewProvider {
    static var previews: some View {
        FestivalDetail()
>>>>>>> postgresDriver
            .body.environmentObject(FestivalDetailModel())
    }
}
