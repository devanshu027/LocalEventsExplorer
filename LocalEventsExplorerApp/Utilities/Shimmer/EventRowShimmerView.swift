//
//  EventRowShimmerView.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 15/04/26.
//

import SwiftUI

struct EventRowShimmerView: View {
    
    var body: some View {
        HStack {
            
            // Image placeholder
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading, spacing: 8) {
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 14)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 12)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 10)
            }
            
            Spacer()
        }
        .padding(.vertical, 6)
        .shimmer() // Apply shimmer
    }
}
