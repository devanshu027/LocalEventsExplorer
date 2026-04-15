//
//  EventRowView.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import SwiftUI
import Kingfisher

struct EventRowView: View {
    
    let event: Event
    let isBookmarked: Bool
    
    // Callback for bookmark toggle
    let onBookmarkTap: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            
            KFImage(URL(string: event.imageURL))
                .placeholder { ProgressView()  // shown while loading
                }
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(event.title)
                    .font(.headline)
                
                Text(event.locationName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            Button(action: onBookmarkTap) {
                Image(systemName: isBookmarked ? "star.fill" : "star")
                    .foregroundColor(.yellow)
            }
            .buttonStyle(.borderless)
        }
    }
}
