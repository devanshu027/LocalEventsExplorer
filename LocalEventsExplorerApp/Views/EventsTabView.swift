//
//  EventsTabView.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 15/04/26.
//

import SwiftUI

struct EventsTabView: View {
    
    // Shared ViewModel & Bookmark store (Single Source of Truth)
    @StateObject private var viewModel = EventListViewModel()
    @StateObject private var bookmarkStore = BookmarkStore()
    
    var body: some View {
        TabView {
            
            // MARK: - All Events Tab
            EventListView(
                viewModel: viewModel,
                bookmarkStore: bookmarkStore
            )
            .tabItem {
                Label("Events", systemImage: "list.bullet")
            }
            
            // MARK: - Bookmarks Tab
            BookmarkListView(
                viewModel: viewModel,
                bookmarkStore: bookmarkStore
            )
            .tabItem {
                Label("Bookmarks", systemImage: "star.fill")
            }
        }
    }
}
