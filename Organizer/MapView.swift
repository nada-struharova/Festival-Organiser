//
//  MapView.swift
//  Organizer
//
//  Created by Nada Struharova on 6/8/23.
//

import CoreLocation
import MapKit

enum MapDetails {
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.04)
}

class MapView: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // TODO: The user denied authorization
        } else if (status == CLAuthorizationStatus.authorizedAlways) {
            // TODO: The user accepted authorization
        }
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            checkLocationAuth()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
        } else {
            print("Show alert to turn on location services")
        }
    }
    
    private func checkLocationAuth() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted, likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. You can change your mind at any time and update your preferences from Settings > Privacy & Security > Location Services.")
        case .authorizedAlways, .authorizedWhenInUse:
            break
            // TODO: center region at user location
//            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
//                                        span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
}
