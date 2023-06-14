//
//  LocationManager.swift
//  Organizer
//
//  Created by Nada Struharova on 6/8/23.
//

import CoreLocation
import MapKit

enum MapDetails {
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.04)
    static let defaultCentre = CLLocationCoordinate2D(latitude: 51.509865, longitude: 0.118092)
    static let defaultRegion = MKCoordinateRegion(center: defaultCentre, span: defaultSpan)
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    @Published var region: MKCoordinateRegion = MapDetails.defaultRegion
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // authorization status changes
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch self.locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted, likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. You can change your mind at any time and update your preferences from Settings > Privacy & Security > Location Services.")
        case .authorizedAlways, .authorizedWhenInUse:
            
            locationManager.startUpdatingLocation()
            
            guard let location = locationManager.location else { return }
            region = MKCoordinateRegion(center: location.coordinate ,
                                        span: MapDetails.defaultSpan)
            
        @unknown default:
            break
        }
    }
    
    func updateLocation() {
        // requests one-time delivery of the user's location
        locationManager.requestLocation()
    }
    
    // user location changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            print("no latest location in location manager updates")
            return
        }
        
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MapDetails.defaultSpan
            )
        }
    }
    
    // location manager failed with error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func setRegion(coord: CLLocationCoordinate2D) {
        region.center = coord
    }

}
