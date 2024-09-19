//
//  LinkResolver.swift
//
//
//  Created by Adis Mulabdic on 15. 9. 2024..
//

import Foundation

public struct LinkResolver {
    
    private let clipboardManager: ClipboardManager
    
    public init() {
        clipboardManager = ClipboardManager()
    }
    
    /// Asynchronously resolves the incoming link and extracts its components
    public static func resolve(url: URL) async -> ResolvedLink? {
        
        if #available(macOS 10.15, *) {
            return await Task { () -> ResolvedLink? in
                let path = url.path // Extract the path of the URL
                let queryParams = extractQueryParameters(from: url) // Extract query parameters
                let fragment = url.fragment // Extract any fragment
                
                // Create the resolved link
                return ResolvedLink(path: path, queryParameters: queryParams, fragment: fragment)
            }.value
        } else {
            let path = url.path // Extracts the path of the URL (e.g., "/some/path")
            let queryParams = extractQueryParameters(from: url) // Extracts query parameters
            let fragment = url.fragment // Extracts any fragment (optional part after #)
            
            return ResolvedLink(path: path, queryParameters: queryParams, fragment: fragment)
        }
    }
    
    /// Helper method to extract query parameters from a URL
    private static func extractQueryParameters(from url: URL) -> [String: String] {
        var queryParams: [String: String] = [:]
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let linkResolver = LinkResolver()
        if let link = linkResolver.pasteLinkFromClipboard() {
            print("Pasted link: \(link)")
        } else {
            print("No link found in clipboard.")
        }
        
        components?.queryItems?.forEach { queryItem in
            if let value = queryItem.value {
                queryParams[queryItem.name] = value
            }
        }
        return queryParams
    }
    
    public func pasteLinkFromClipboard() -> String? {
        return clipboardManager.getTextFromClipboard()
    }
}

/// A struct representing a resolved dynamic link
public struct ResolvedLink {
    public let path: String
    public let queryParameters: [String: String]
    public let fragment: String?
}
