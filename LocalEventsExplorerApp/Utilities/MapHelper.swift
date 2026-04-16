//
//  MapHelper.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 15/04/26.
//

import Foundation
import MapKit

struct MapHelper {
    
    static func openMaps(for event: Event) {
            
            let latitude = event.latitude
            let longitude = event.longitude
        
            let urlString = "http://maps.apple.com/?daddr=\(latitude),\(longitude)"
            
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
}
