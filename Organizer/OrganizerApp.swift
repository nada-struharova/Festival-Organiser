//
//  OrganizerApp.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import SwiftUI

@main
struct OrganizerAppApp: App {
    
    @StateObject var dataModel = FestivalDataService()
    
    @Environment (\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataModel)
        }
    }
}
