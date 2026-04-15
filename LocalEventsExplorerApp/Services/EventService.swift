//
//  EventService.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import Foundation
import Combine

protocol EventServiceProtocol {
    func getEvents() -> AnyPublisher<[Event], Never>
}

// Handles API + fallback
final class EventService: EventServiceProtocol {
    
    private let apiClient: APIClientProtocol
    private let repository: EventRepositoryProtocol
    
    init(apiClient: APIClientProtocol = APIClient(),
         repository: EventRepositoryProtocol = EventRepository()) {
        self.apiClient = apiClient
        self.repository = repository
    }
    
    func getEvents() -> AnyPublisher<[Event], Never> {
        apiClient.fetchEvents()
            .handleEvents(receiveOutput: { [weak self] events in
                self?.repository.save(events: events)
            })
            .catch { [weak self] _ in
                self?.repository.fetchEvents() ?? Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
