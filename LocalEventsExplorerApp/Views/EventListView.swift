//
//  EventListView.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import SwiftUI
import Combine

struct EventListView: View {
    
    @StateObject private var viewModel = EventListViewModel()
    @StateObject private var bookmarkStore = BookmarkStore()
    
    var body: some View {
        NavigationView {
            List(viewModel.events) { event in
                
                NavigationLink(
                    destination: EventDetailView(event: event)
                ) {
                    EventRowView(
                        event: event,
                        isBookmarked: bookmarkStore.isBookmarked(id: event.id),
                        onBookmarkTap: {
                            bookmarkStore.toggleBookmark(id: event.id)
                        }
                    )
                }
            }
            .navigationTitle("Events")
        }
        .onAppear {
            viewModel.fetchTrigger.send(())
        }
    }
}

#Preview {
    EventListView()
}
