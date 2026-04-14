//
//  EventServiceTests.swift
//  LocalEventsExplorerAppTests
//
//  Created by Devanshu on 14/04/26.
//

import XCTest
@testable import LocalEventsExplorerApp
import Combine

final class EventServiceTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func test_API_Success_ShouldReturnEvents_AndSave() {
        
        let api = MockAPIClient()
        let repo = MockRepository()
        
        let service = EventService(apiClient: api, repository: repo)
        
        let expectation = XCTestExpectation(description: "Fetch success")
        
        service.getEvents()
            .sink { events in
                
                XCTAssertEqual(events.count, 1)  // API returned
                XCTAssertEqual(repo.storedEvents.count, 1) // Saved
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_API_Failure_ShouldReturnCachedEvents() {
        
        let api = MockAPIClient()
        api.shouldFail = true
        
        let repo = MockRepository()
        repo.storedEvents = [
            Event(id: "cached", title: "Offline Event",
                  locationName: "Delhi",
                  latitude: 0, longitude: 0,
                  date: Date(), imageURL: "")
        ]
        
        let service = EventService(apiClient: api, repository: repo)
        
        let expectation = XCTestExpectation(description: "Fallback works")
        
        service.getEvents()
            .sink { events in
                
                XCTAssertEqual(events.first?.id, "cached") // fallback
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_ViewModel_ShouldUpdateEvents() {
            
            let api = MockAPIClient()
            let repo = MockRepository()
            
            let service = EventService(apiClient: api, repository: repo)
            let viewModel = EventListViewModel(service: service)
            
            let expectation = XCTestExpectation(description: "UI updated")
            
            viewModel.$events
                .dropFirst() // ignore initial empty
                .sink { events in
                    
                    XCTAssertEqual(events.count, 1)
                    expectation.fulfill()
                }
                .store(in: &cancellables)
            
            viewModel.fetchTrigger.send(())
            
            wait(for: [expectation], timeout: 2)
        }
}
