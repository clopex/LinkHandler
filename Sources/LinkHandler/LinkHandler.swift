// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct LinkHandler {
    
    /// Asynchronously handles incoming links and resolves them
    public static func handleIncomingLink(_ url: URL) async -> ResolvedLink? {
        // Use the async resolver
        return await LinkResolver.resolve(url: url)
    }
}
