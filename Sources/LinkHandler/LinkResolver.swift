//
//  LinkResolver.swift
//
//
//  Created by Adis Mulabdic on 15. 9. 2024..
//

import Foundation

public struct LinkResolver {
    
    private let options: PasteOption
    
    public init(option: PasteOption = .clipboard) {
        self.options = option
    }
    
    /// Asynchronously resolves the incoming link and extracts its components
    public func resolve(url: URL) async -> ResolvedLink? {
        
        if #available(macOS 10.15, *) {
            return await Task { () -> ResolvedLink? in
                let path = url.path // Extract the path of the URL
                let fullUrl = url.absoluteString // Extract the complete url
                let queryParams = extractQueryParameters(from: url) // Extract query parameters
                let fragment = url.fragment // Extract any fragment
                let linkResolver = LinkResolver()
                let copiedData = linkResolver.getCopiedData()
                // Create the resolved link
                return ResolvedLink(path: path, copiedData: copiedData, url: fullUrl, queryParameters: queryParams, fragment: fragment)
            }.value
        } else {
            let linkResolver = LinkResolver()
            let path = url.path // Extracts the path of the URL (e.g., "/some/path")
            let queryParams = extractQueryParameters(from: url) // Extracts query parameters
            let fragment = url.fragment // Extracts any fragment (optional part after #)
            let copiedData = linkResolver.getCopiedData()
            let fullUrl = url.absoluteString // Extract the complete url
            
            return ResolvedLink(path: path, copiedData: copiedData, url: fullUrl, queryParameters: queryParams, fragment: fragment)
        }
    }
    
    /// Helper method to extract query parameters from a URL
    private func extractQueryParameters(from url: URL) -> [String: String] {
        var queryParams: [String: String] = [:]
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        components?.queryItems?.forEach { queryItem in
            if let value = queryItem.value {
                queryParams[queryItem.name] = value
            }
        }
        return queryParams
    }
    
    private func getCopiedData() -> String? {
        if !UserDefaults.firstLaunch {
            switch options {
                case .clipboard:
                    return getDataFromClipboard()
                case .cookies(let name):
                    return getDataFromCookie(by: name)
                case .script:
                    return ""
            }
        }
        return nil
    }
    
    private func getDataFromClipboard() -> String? {
        UserDefaults.firstLaunch = true
        let clipboardManager = ClipboardManager()
        return clipboardManager.getTextFromClipboard
    }
    
    private func getDataFromCookie(by name: String) -> String? {
        if let cookies = HTTPCookieStorage.shared.cookies {
            if let cookie = cookies.first(where: { $0.name == name }) {
                return cookie.value
            }
        }
        return nil
    }
}

/// A struct representing a resolved dynamic link
public struct ResolvedLink {
    public let path: String?
    public let copiedData: String?
    public let url: String?
    public let queryParameters: [String: String]
    public let fragment: String?
}
