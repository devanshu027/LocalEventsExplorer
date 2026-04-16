//
//  EventDetailView.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 14/04/26.
//

import SwiftUI
import MapKit
import Kingfisher

struct EventDetailView: View {
    
    let event: Event
    let userLocation: CLLocation?
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                
                KFImage(URL(string: event.imageURL))
                    .placeholder { ProgressView() }
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(event.title)
                    .font(.title)
                    .bold()
                
                Text(event.locationName)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("About Event")
                        .font(.headline)
                    
                    Text(event.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Text(event.distance(from: userLocation))
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                Text(event.date, style: .date)
                    .font(.subheadline)
                
                // MARK: - Navigation Button
                Button {
                    MapHelper.openMaps(for: event)
                } label: {
                    HStack {
                        Image(systemName: "map")
                        Text("Get Directions")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }
}
