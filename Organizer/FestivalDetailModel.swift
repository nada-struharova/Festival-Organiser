//
//  FestivalDetailModel.swift
//  Organizer
//
//  Created by Nada Struharova on 6/8/23.
//

import Foundation
import CoreLocation
import MapKit

enum MapDetails {
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.04)
}

class FestivalDetailModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    @Published var festival: Festival
    
    @Published private(set) var pois = [PointOfInterest]()
    
    @Published var selectedPlace: PointOfInterest?
    
    @Published var region: MKCoordinateRegion
    
    init(festival: Festival, selectedPlace: PointOfInterest? = nil) {
        self.festival = festival
        self.pois = festival.getPois()
        self.selectedPlace = selectedPlace
        self.region = MKCoordinateRegion(center: festival.centreCoordinate(), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.04))
    }
    
    
    func addPoi() {
        let newPoi = PointOfInterest(name: "", type: POIType.Stage, latitude: region.center.latitude, longitude: region.center.longitude)
        pois.append(newPoi)
    }
    
    
    func updatePoi(updatedPoi: PointOfInterest) {
        guard let selectedPlace = selectedPlace else { return }
        
        if let index = pois.firstIndex(of: selectedPlace) {
            pois[index] = updatedPoi
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
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
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
}
