//
//  FestivalRow.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct FestivalRow: View {
    
    var festival: Festival
        
    var body : some View {
        HStack {
            Text(festival.displayName ?? "Unknown")
            Spacer()
        }
    }
}

struct FestivalRow_Previews: PreviewProvider {
    static var previews: some View {
        FestivalRow(festival: Festival(id: 1, displayName: "Leeds", centreLat: 0, centreLong: 0, height: 0, width: 0, stages: ["Hola" : CLLocationCoordinate2D(latitude: 0, longitude: 0)]))
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
