//
//  LinkResolver.swift
//
//
//  Created by Adis Mulabdic on 15. 9. 2024..
//

import Foundation

public struct LinkHandler {
    
    private let option: PasteOption
    
    init(option: PasteOption = .clipboard) {
        self.option = option
    }
    
    /// Asynchronously handles incoming links and resolves them
    public func handleIncomingLink(_ url: URL) async -> ResolvedLink? {
        // Use the async resolver
        let resolver = LinkResolver(option: option)
        return await resolver.resolve(url: url)
    }
}
