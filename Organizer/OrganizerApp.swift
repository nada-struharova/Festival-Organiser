//
//  OrganizerApp.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import SwiftUI

@main
struct OrganizerAppApp: App {
    
    //@StateObject var data = FestivalData
    
    @Environment (\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("in background")
            @unknown default:
                print("oops")
            }
        }
    }
}
