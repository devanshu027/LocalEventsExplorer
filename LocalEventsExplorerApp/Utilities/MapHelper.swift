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
        
        let coordinate = CLLocationCoordinate2D(
            latitude: event.latitude,
            longitude: event.longitude
        )
        
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = event.title
        
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}
