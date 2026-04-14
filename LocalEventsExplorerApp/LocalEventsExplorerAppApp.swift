//
//  LocalEventsExplorerAppApp.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import SwiftUI
import CoreData

@main
struct LocalEventsExplorerAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
