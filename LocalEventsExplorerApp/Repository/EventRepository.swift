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
    func save(events: [Event]) throws
    func fetchEvents() -> AnyPublisher<[Event], Never>
}

final class EventRepository: EventRepositoryProtocol {
    
    
    private let context = PersistenceController.shared.container.viewContext
    
    // Saving events to the database
    func save(events: [Event]) throws {
        deleteAll()
        
        do {
            events.forEach { event in
                let entity = CD_Event(context: context)
                entity.populate(from: event)
            }
            
            try context.save()
            
        } catch {
            throw AppError.unknown(error)
        }
    }
    
    // Fetch events from the database
    func fetchEvents() -> AnyPublisher<[Event], Never> {
        Future { promise in
            let request: NSFetchRequest<CD_Event> = CD_Event.fetchRequest()
            let result = (try? self.context.fetch(request)) ?? []
            promise(.success(result.map { $0.toDomain() }))
        }
        .eraseToAnyPublisher()
    }
    
    // Empty the database
    private func deleteAll() {
        let request: NSFetchRequest<NSFetchRequestResult> = CD_Event.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        _ = try? context.execute(delete)
    }
}
