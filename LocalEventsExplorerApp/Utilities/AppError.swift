//
//  AppError.swift
//  LocalEventsExplorerApp
//
//  Created by Devanshu on 16/04/26.
//

import Foundation

// Centralized error handling
enum AppError: LocalizedError {
    
    case network
    case decoding
    case fileNotFound
    case unknown(Error)
    
    // User-friendly messages
    var errorDescription: String? {
        switch self {
        case .network:
            return "Please check your internet connection."
        case .decoding:
            return "Failed to load data. Please try again."
        case .fileNotFound:
            return "Data source not found."
        case .unknown:
            return "Something went wrong. Please try again."
        }
    }
}
