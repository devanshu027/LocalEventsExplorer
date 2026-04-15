//
//  ShimmerModifier.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 15/04/26.
//

import Foundation
import SwiftUI

struct ShimmerModifier: ViewModifier {
    
    @State private var phase: CGFloat = -1
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.gray.opacity(0.3),
                        Color.gray.opacity(0.1),
                        Color.gray.opacity(0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .rotationEffect(.degrees(30))
                .offset(x: phase * 300)
            )
            .mask(content)
            .onAppear {
                withAnimation(
                    .linear(duration: 1.2)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = 1.5
                }
            }
    }
}

// extension
extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}
