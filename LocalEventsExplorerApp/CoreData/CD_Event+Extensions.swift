//
//  CD_Event+Extensions.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import Foundation
import CoreData

extension CD_Event {
    
    func populate(from event: Event) {
        id = event.id
        title = event.title
        locationName = event.locationName
        latitude = event.latitude
        longitude = event.longitude
        date = event.date
        imageURL = event.imageURL
    }
    
    func toDomain() -> Event {
        Event(
            id: id ?? "",
            title: title ?? "",
            locationName: locationName ?? "",
            latitude: latitude,
            longitude: longitude,
            date: date ?? Date(),
            imageURL: imageURL ?? ""
        )
    }
}
