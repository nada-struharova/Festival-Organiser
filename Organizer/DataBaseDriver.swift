//
//  DatabaseDriver.swift
//  Organizer
//
//  Created by bp821 on 06/06/2023.
//

import Foundation

protocol DataBaseDriver {
    func close()
    func connect() -> Bool
    func addFestival(festival: Festival)
    func getFestivalList() -> [Int]
    func getDisplayNames() -> [Int : String]
    func getFestival(festivalID: Int) -> Festival
}
