//
//  BookmarkListView.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 15/04/26.
//

import SwiftUI

struct BookmarkListView: View {
    // Shared ViewModel (contains all events)
    @ObservedObject var viewModel: EventListViewModel
    
    // Bookmark store (single source of truth)
    @ObservedObject var bookmarkStore: BookmarkStore
    @StateObject private var locationService = LocationService()
    
    var body: some View {
        NavigationView {
            
            // Filter only bookmarked events
            let bookmarkedEvents = viewModel.events.filter {
                bookmarkStore.isBookmarked(id: $0.id)
            }
            
            // Handle empty state
            if bookmarkedEvents.isEmpty {
                Text("No bookmarked events ⭐")
                    .foregroundColor(.gray)
            } else {
                List(bookmarkedEvents) { event in
                    
                    NavigationLink(
                        destination: EventDetailView(event: event, userLocation: locationService.location)
                    ) {
                        EventRowView(
                            event: event,
                            isBookmarked: true,
                            onBookmarkTap: {
                                bookmarkStore.toggleBookmark(id: event.id)
                            }
                        )
                    }
                }
            }
        }
        .navigationTitle("Bookmarks")
        .toolbar(.visible, for: .tabBar) 
    }
}
