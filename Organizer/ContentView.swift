//
//  ContentView.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//
import SwiftUI
import MapKit

struct ContentView: View {
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.520627,
                                       longitude: -0.101602),
        span: MKCoordinateSpan(latitudeDelta: 0.03,
                               longitudeDelta: 0.04))
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $region)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

