//
//  LocationManager.swift
//  arbuz.kz
//
//  Created by Аброрбек on 22.05.2023.
//

import CoreLocation
import Foundation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    var completion: ((CLLocation) -> Void)?
    
    public func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    public func resolveLocationName(with location: CLLocation,
                                    completion: @escaping((String?) -> Void)){
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
            guard let place = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            
            var name = ""
            
            if let street = place.name {
                name += street
            }
            
            completion(name)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]) {
        guard let location = location.first else {
            return
        }
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
