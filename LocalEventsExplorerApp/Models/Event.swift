//
//  Event.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import Foundation
import CoreLocation

struct Event: Identifiable, Codable {
    let id: String
    let title: String
    let locationName: String
    let latitude: Double
    let longitude: Double
    let date: Date
    let imageURL: String
    let description: String
}
