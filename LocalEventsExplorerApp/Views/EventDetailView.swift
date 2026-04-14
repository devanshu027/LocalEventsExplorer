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
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                
                KFImage(URL(string: event.imageURL))
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .clipped()
                    .cornerRadius(12)
                
                Text(event.title)
                    .font(.title)
                    .bold()
                
                Text(event.locationName)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Text(event.date, style: .date)
                    .font(.subheadline)
                
                Map(
                    coordinateRegion: .constant(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: event.latitude,
                                longitude: event.longitude
                            ),
                            span: MKCoordinateSpan(
                                latitudeDelta: 0.01,
                                longitudeDelta: 0.01
                            )
                        )
                    )
                )
                .frame(height: 250)
                .cornerRadius(12)
            }
            .padding()
        }
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
