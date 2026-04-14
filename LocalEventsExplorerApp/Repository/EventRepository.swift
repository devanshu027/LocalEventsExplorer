//
//  EventRepository.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import Foundation
import CoreData
import Combine

protocol EventRepositoryProtocol {
    func save(events: [Event])
    func fetchEvents() -> AnyPublisher<[Event], Never>
}

final class EventRepository: EventRepositoryProtocol {
    
    private let context = PersistenceController.shared.container.viewContext
    
    func save(events: [Event]) {
        deleteAll()
        
        events.forEach {
            let entity = CD_Event(context: context)
            entity.populate(from: $0)
        }
        
        try? context.save()
    }
    
    func fetchEvents() -> AnyPublisher<[Event], Never> {
        Future { promise in
            let request: NSFetchRequest<CD_Event> = CD_Event.fetchRequest()
            let result = (try? self.context.fetch(request)) ?? []
            promise(.success(result.map { $0.toDomain() }))
        }
        .eraseToAnyPublisher()
    }
    
    private func deleteAll() {
        let request: NSFetchRequest<NSFetchRequestResult> = CD_Event.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        _ = try? context.execute(delete)
    }
}
