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
    @Published var searchText: String = ""
    @Published private(set) var filteredEvents: [Event] = []
    
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
        
        // SEARCH + FILTER (WITH DEBOUNCE)
        Publishers.CombineLatest(
            $searchText
                .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
                .removeDuplicates(),
            $events
        )
        .map { searchText, events in
            
            guard !searchText.isEmpty else {
                return events
            }
            
            return events.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.locationName.localizedCaseInsensitiveContains(searchText)
            }
        }
        .receive(on: DispatchQueue.main)
        .assign(to: &$filteredEvents)
    }
    
    func fetchIfNeeded() {
        guard events.isEmpty else { return }
        fetchTrigger.send(())
    }
}
