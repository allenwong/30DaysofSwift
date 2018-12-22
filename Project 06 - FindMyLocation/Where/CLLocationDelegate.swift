//
//  CLLocationDelegate.swift
//  Where
//
//  Created by qianyb on 2018/12/22.
//  Copyright © 2018 Allen. All rights reserved.
//

import Foundation
import CoreLocation

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        self.locationLabel.text = "Error while updating location " + error.localizedDescription
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations.first!) { (placemarks, error) in
            guard error == nil else {
                self.locationLabel.text = "Reverse geocoder failed with error" + error!.localizedDescription
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks!.first
                self.displayLocationInfo(pm)
            } else {
                self.locationLabel.text = "Problem with the data received from geocoder"
            }
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
//
//            if (error != nil) {
//                self.locationLabel.text = "Reverse geocoder failed with error" + error!.localizedDescription
//                return
//            }
//
//            if placemarks!.count > 0 {
//                let pm = placemarks![0]
//                self.displayLocationInfo(pm)
//            } else {
//                self.locationLabel.text = "Problem with the data received from geocoder"
//            }
//        })
//    }
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            
            self.locationLabel.text = postalCode! + " " + locality!
            
            self.locationLabel.text?.append("\n" + administrativeArea! + ", " + country!)
        }
        
    }
}
