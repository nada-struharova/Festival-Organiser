//
//  ContentView.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//
import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = FestivalDataService()
    
    var body: some View {
        FestivalList().environmentObject(viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .body.environmentObject(FestivalDataService())
    }
}

