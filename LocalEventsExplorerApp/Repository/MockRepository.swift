//
//  MockRepository.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import Foundation
import Combine

final class MockRepository: EventRepositoryProtocol {
    
    var storedEvents: [Event] = []
    
    func save(events: [Event]) {
        storedEvents = events
    }
    
    func fetchEvents() -> AnyPublisher<[Event], Never> {
        Just(storedEvents).eraseToAnyPublisher()
    }
}
