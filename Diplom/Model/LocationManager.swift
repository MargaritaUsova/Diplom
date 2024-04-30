//
//  LocationManager.swift
//  Diplom
//
//  Created by Margarita Usova on 14.04.2024.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate{
    static let shared = LocationManager()
    
    public let locationManager = CLLocationManager()
    public var userLatitude: Double = 55.7558
    public var userLongtitude: Double = 37.6173
    
    override private init() {
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
        if let location = locations.first {
            userLatitude = location.coordinate.latitude
            userLongtitude = location.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Got error: ", error)
       
    }
    
}
