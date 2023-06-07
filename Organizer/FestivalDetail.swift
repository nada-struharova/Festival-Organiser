//
//  FestivalDetail.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import SwiftUI
import MapKit

struct FestivalDetail: View {
    
    var festival: Festival
    
    @EnvironmentObject private var detailModel: FestivalDetailModel
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.520627,
                                       longitude: -0.101602),
        span: MKCoordinateSpan(latitudeDelta: 0.03,
                               longitudeDelta: 0.04))
    
    init(festival: Festival) {
        self.festival = festival
        setRegion(CLLocationCoordinate2D(latitude: festival.centreLat, longitude: festival.centreLong))
        print(region.center)
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
             
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
            .body.environmentObject(FestivalDetailModel())
    }
}
