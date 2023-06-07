//
//  FestivalDataService.swift
//  Organizer
//
//  Created by Nada Struharova on 6/6/23.
//

import Foundation
import MapKit

class FestivalDataService : ObservableObject {
    var driver: DataBaseDriver
    var festivalIds: [Int]
    var allFestivals: [Festival]
    @Published var festivals: [Festival] = []
    
    init() {
        self.driver = PostgreSQLDriver()
        self.festivalIds = []
        self.allFestivals = []
        self.festivals = getUserFestivals()
        print(self.festivals)
    }
    
    func start() {
        
        driver.connect()
        festivalIds = driver.getFestivalList()
    }
    
    func getUserFestivals() -> [Festival]{
        start()
        for id in festivalIds {
            allFestivals.append(driver.getFestival(festivalID: id))
        }
        driver.close()
        return allFestivals
    }
}
