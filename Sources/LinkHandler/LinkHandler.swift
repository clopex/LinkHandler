//
//  LinkResolver.swift
//
//
//  Created by Adis Mulabdic on 15. 9. 2024..
//

import Foundation

public struct LinkHandler {
    
    /// Asynchronously handles incoming links and resolves them
    public static func handleIncomingLink(_ url: URL) async -> ResolvedLink? {
        // Use the async resolver
        return await LinkResolver.resolve(url: url)
    }
}
