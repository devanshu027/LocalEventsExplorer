//
//  BookmarkStore.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import Foundation
import Combine

final class BookmarkStore: ObservableObject {
    
    @Published private(set) var bookmarkedIds: Set<String> = []
    
    private let key = "bookmarked_events"
    
    init() {
        load()
    }
    
    func toggleBookmark(id: String) {
        if bookmarkedIds.contains(id) {
            bookmarkedIds.remove(id)
        } else {
            bookmarkedIds.insert(id)
        }
        save()
    }
    
    func isBookmarked(id: String) -> Bool {
        bookmarkedIds.contains(id)
    }
    
    private func save() {
        UserDefaults.standard.set(Array(bookmarkedIds), forKey: key)
    }
    
    private func load() {
        let saved = UserDefaults.standard.stringArray(forKey: key) ?? []
        bookmarkedIds = Set(saved)
    }
}
