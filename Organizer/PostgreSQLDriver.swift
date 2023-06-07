//
//  PostgreSQLDriver.swift
//  Organizer
//
//  Created by bp821 on 06/06/2023.
//

import Foundation
import PostgresClientKit
import CoreLocation

class PostgreSQLDriver : NSObject, DataBaseDriver {

    private var configuration: ConnectionConfiguration
    private var connection: Connection?
    private var displayNamesCache: [Int : String]? = nil
    
    private var userId = "bjorna"
    
    override init() {
        var prefsSQL: NSDictionary?
        if let path = Bundle.main.path(forResource: "PrefsSQL", ofType: "plist") {
            prefsSQL = NSDictionary(contentsOfFile: path)
        }
        
        configuration = PostgresClientKit.ConnectionConfiguration()
        configuration.ssl = prefsSQL!["ssl"] as! Bool
        configuration.host = prefsSQL!["host"] as! String
        configuration.database = prefsSQL!["dbName"] as! String
        configuration.user = prefsSQL!["user"] as! String
        configuration.port = prefsSQL!["port"] as! Int
        let password = prefsSQL!["password"] as! String
        switch (prefsSQL!["authMethod"] as! String) {
            case "clearText": configuration.credential = Credential.cleartextPassword(password: password)
            case "trust": configuration.credential = Credential.trust
            default: configuration.credential = Credential.scramSHA256(password: password)
        }
    }
    
    func close() {
        displayNamesCache = nil
        connection?.close()
    }
    
    func connect() -> Bool {
        do {
            connection = try PostgresClientKit.Connection(configuration: configuration)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func getFestivalList() -> [Int] {
        return Array(getDisplayNames().keys)
    }
    
    func getDisplayNames() -> [Int : String] {
        if (displayNamesCache == nil) {
            var festivals: [Int : String] = [:]
            do {
                let text = "SELECT festival, displayname FROM festivals WHERE userid = $1;"
                let statement = try connection!.prepareStatement(text: text)
                defer { statement.close() }
                
                let cursor = try statement.execute(parameterValues: [userId])
                defer { cursor.close() }
                
                for row in cursor {
                    let columns = try row.get().columns
                    let festival = try columns[0].int()
                    let displayname = try columns[1].string()
                    festivals[festival] = displayname
                }
                displayNamesCache = festivals
            } catch {
                print(error)
            }
            return festivals
        }
        return displayNamesCache!
    }
    
    func getFestival(festivalID: Int) -> Festival {
            let name = String(festivalID)
            do {
                
                let text0 = "SELECT festival, displayname, centre_lat, centre_long, height, width FROM festivals WHERE festival = $1;"
                let statement0 = try connection!.prepareStatement(text: text0)
                defer { statement0.close() }

                let cursor0 = try statement0.execute(parameterValues: [ name ])
                defer { cursor0.close() }

                var centre: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
                var height: Double = 0
                var width: Double = 0
                var displayname: String? = nil
                
                for row in cursor0 {
                    let columns = try row.get().columns
                    displayname = try columns[1].string()
                    let centre_lat = try columns[2].double()
                    let centre_long = try columns[3].double()
                centre = CLLocationCoordinate2D(latitude: centre_lat, longitude: centre_long)
                height = try columns[4].double()
                width = try columns[5].double()
            }
            
            if displayNamesCache?[festivalID] != displayname {
                displayNamesCache = nil
            }
            
            let text1 = "SELECT festival, stage, lat, long FROM stages WHERE festival = $1;"
            let statement1 = try connection!.prepareStatement(text: text1)
            defer { statement1.close() }

            let cursor1 = try statement1.execute(parameterValues: [ name ])
            defer { cursor1.close() }
            
            var stages: [String : CLLocationCoordinate2D] = [:]
            
            for row in cursor1 {
                let columns = try row.get().columns
                let stage = try columns[1].string()
                let lat = try columns[2].double()
                let long = try columns[3].double()
                stages[stage] = CLLocationCoordinate2D(latitude: lat, longitude: long)
            }
            
            let text2 = "SELECT festival, lat, long FROM toilets WHERE festival = $1;"
            let statement2 = try connection!.prepareStatement(text: text2)
            defer { statement2.close() }

            let cursor2 = try statement2.execute(parameterValues: [ name ])
            defer { cursor2.close() }
            
            var toilets: [CLLocationCoordinate2D] = []
            
            for row in cursor2 {
                let columns = try row.get().columns
                let lat = try columns[1].double()
                let long = try columns[2].double()
                toilets.append(CLLocationCoordinate2D(latitude: lat, longitude: long))
            }
            
            let text3 = "SELECT festival, lat, long FROM waters WHERE festival = $1;"
            let statement3 = try connection!.prepareStatement(text: text3)
            defer { statement3.close() }

            let cursor3 = try statement3.execute(parameterValues: [ name ])
            defer { cursor3.close() }
            
            var waters: [CLLocationCoordinate2D] = []
            
            for row in cursor3 {
                let columns = try row.get().columns
                let lat = try columns[1].double()
                let long = try columns[2].double()
                waters.append(CLLocationCoordinate2D(latitude: lat, longitude: long))
            }
            
                let festival = Festival(id: festivalID, displayName: displayname, centreLat: centre.latitude, centreLong: centre.longitude, height: height, width: width, stages: stages, toilets: toilets, waters: waters)
            return festival
            
        } catch {
            print(error) // better error handling goes here
        }
        return Festival(id: 0, displayName: nil, centreLat: 0, centreLong: 0, height: 0, width: 0, stages: [:], toilets: nil, waters: nil)
    }
    
    func addFestival(festival: Festival) {
        do {
            var festivalId: Int? = 0
            
            // Insert festival
            let text0 = "INSERT INTO festivals (displayname, centre_lat, centre_long, height, width, userid) VALUES($1, $2, $3, $4, $5, $6)"
            let statement0 = try connection!.prepareStatement(text: text0)
            defer { statement0.close() }
            
            let cursor0 = try statement0.execute(parameterValues: [festival.displayName, festival.centreLat, festival.centreLong, festival.height, festival.width, userId])
            defer { cursor0.close() }
            
            // Get the generated festival id
            let text4 = "SELECT MAX(festival) AS festivalId FROM festivals;"
            let statement4 = try connection!.prepareStatement(text: text4)
            defer { statement4.close() }

            let cursor4 = try statement4.execute(parameterValues: [])
            defer { cursor4.close() }
            
            for row in cursor4 {
                let columns = try row.get().columns
                festivalId = try columns[0].int()
            }
            
            // Add festivals
            for (name, cord) in festival.stages {
                let text1 = "INSERT INTO stages (festival, stage, lat, long) VALUES ($1, $2, $3, $4);"
                let statement1 = try connection!.prepareStatement(text: text1)
                defer { statement1.close() }

                let cursor1 = try statement1.execute(parameterValues:  [festivalId, name, cord.latitude, cord.longitude])
                do { cursor1.close() }
                
            }
        
            // Add toilets
            for cord in festival.toilets ?? [] {
                
                let text2 = "INSERT INTO toilets (festival, lat, long) VALUES ($1, $2, $3);"
                let statement2 = try connection!.prepareStatement(text: text2)
                defer { statement2.close() }
                    
                let cursor2 = try statement2.execute(parameterValues: [festivalId, cord.latitude, cord.longitude])
                do { cursor2.close() }
            }
            
            // Add waters
            for cord in festival.waters ?? [] {
       
                let text3 = "INSERT INTO waters (festival, lat, long) VALUES ($1, $2, $3);"
                let statement3 = try connection!.prepareStatement(text: text3)
                defer { statement3.close() }
                    
                let cursor3 = try statement3.execute(parameterValues: [festivalId, cord.latitude, cord.longitude])
                do { cursor3.close() }
            }
            
        } catch {
        print(error) // better error handling goes here
    }
    }
 
}
