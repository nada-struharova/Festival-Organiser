//
//  FestivalList.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import Foundation
import SwiftUI

struct FestivalList: View {
    
    @EnvironmentObject private var db: FestivalDataService
    
    var body : some View {
        NavigationView {
            List(db.festivals) { fest in
                NavigationLink {
                    FestivalDetail(festival: fest)
                } label: {
                    FestivalRow(festival: fest)
                }
            }
            
            .navigationTitle("Your Festivals")
        }
    }
}

struct FestivalList_Previews: PreviewProvider {
    static var previews: some View {
        FestivalList()
            .environmentObject(FestivalDataService())
    }
}
