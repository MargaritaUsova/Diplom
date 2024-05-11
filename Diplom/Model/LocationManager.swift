//
//  LocationManager.swift
//  Diplom
//
//  Created by Margarita Usova on 14.04.2024.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate{
    
    private let locationManager = CLLocationManager()
    static var userLatitude: Double = 55.7558
    static var userLongtitude: Double = 37.6173
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        DispatchQueue.global().async {
            
            if let location = locations.first {
                LocationManager.userLatitude = location.coordinate.latitude
                LocationManager.userLongtitude = location.coordinate.longitude
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Got error with location: ", error)
    }
    
}


