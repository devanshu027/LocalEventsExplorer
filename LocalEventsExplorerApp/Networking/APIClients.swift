//
//  APIClients.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import Foundation
import Combine

protocol APIClientProtocol {
    func fetchEvents() -> AnyPublisher<[Event], Error>
}

final class APIClient: APIClientProtocol {
    
    func fetchEvents() -> AnyPublisher<[Event], Error> {
        guard let url = Bundle.main.url(forResource: "event", withExtension: "json") else {    //Through Local JSON
                    return Fail(error: URLError(.fileDoesNotExist))
                        .eraseToAnyPublisher()
                }
                
                return Just(url)
                    .tryMap { try Data(contentsOf: $0) }
                    .decode(type: [Event].self, decoder: decoder)
                    .delay(for: .seconds(1), scheduler: DispatchQueue.main)
                    .eraseToAnyPublisher()
        
//        URLSession.shared.dataTaskPublisher(for: Endpoints.events)
//            .map(\.data)
//            .decode(type: [Event].self, decoder: decoder)              // If we go through API endpoint URL
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
    }
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
