//
//  EventListView.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import SwiftUI
import Combine

struct EventListView: View {
    
    @ObservedObject var viewModel: EventListViewModel
    @EnvironmentObject var bookmarkStore: BookmarkStore
    @StateObject private var locationService = LocationService()
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                
                // Show shimmer list
                List(0..<6, id: \.self) { _ in
                    EventRowShimmerView()
                }
                
            } else {
                
                // Actual Data
                List(viewModel.filteredEvents) { event in
                    
                    NavigationLink(
                        destination: EventDetailView(event: event, userLocation: locationService.location)
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
                .searchable(text: $viewModel.searchText, prompt: "Search events")
                .refreshable {
                    // Pull to refresh triggers API again
                    viewModel.fetchTrigger.send(())
                }
            }
        }
        .navigationTitle("Events")
        .toolbar(.visible, for: .tabBar)
        .onAppear {
            viewModel.fetchIfNeeded()
            locationService.requestPermission()
            locationService.startUpdating()
        }
    }
}
