//
//  FestivalDetail.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import SwiftUI
import MapKit

struct FestivalDetail {
    
    @EnvironmentObject private var vm: FestivalDetailModel
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.520627,
                                       longitude: -0.101602),
        span: MKCoordinateSpan(latitudeDelta: 0.03,
                               longitudeDelta: 0.04))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
        }
    }
}

struct FestivalDetail_Previews: PreviewProvider {
    static var previews: some View {
        FestivalDetail()
            .body.environmentObject(FestivalDetailModel())
    }
}
