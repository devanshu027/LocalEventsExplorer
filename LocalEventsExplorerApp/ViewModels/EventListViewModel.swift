//
//  EventListViewModel.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import Foundation
import Combine
import CoreLocation

final class EventListViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    @Published var isLoading = false
    
    let fetchTrigger = PassthroughSubject<Void, Never>()
    
    private let service: EventServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: EventServiceProtocol = EventService()) {
        self.service = service
        bind()
    }
    
    private func bind() {
        fetchTrigger
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = true
            })
            .flatMap { [weak self] _ -> AnyPublisher<[Event], Never> in
                self?.service.getEvents() ?? Just([]).eraseToAnyPublisher()
            }
            .sink { [weak self] events in
                self?.events = events
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
}
