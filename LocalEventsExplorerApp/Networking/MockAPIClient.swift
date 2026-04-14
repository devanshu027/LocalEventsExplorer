//
//  MockAPIClient.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import Foundation
import Combine

final class MockAPIClient: APIClientProtocol {
    
    var shouldFail = false
    
    func fetchEvents() -> AnyPublisher<[Event], Error> {
        
        if shouldFail {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
        
        return Just([
            Event(id: "1", title: "Test Event", locationName: "Lucknow",
                  latitude: 0, longitude: 0, date: Date(), imageURL: "")
        ])
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
    }
}
