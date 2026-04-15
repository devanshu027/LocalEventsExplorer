//
//  Event+Distance.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 15/04/26.
//

import Foundation
import CoreLocation

extension Event {
    
    func distance(from userLocation: CLLocation?) -> String {
        guard let userLocation else { return "N/A" }
        
        let eventLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        let distanceInMeters = userLocation.distance(from: eventLocation)
        
        let km = distanceInMeters / 1000
        
        return String(format: "%.1f km away", km)
    }
}
