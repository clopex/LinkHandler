//
//  File.swift
//  LinkHandler
//
//  Created by Adis Mulabdic on 19. 9. 2024..
//

import Foundation
#if canImport(UIKit)
import UIKit

public class ClipboardManager {

    public init() {}

    public func getTextFromClipboard() -> String? {
        return UIPasteboard.general.string
    }

    public func setTextToClipboard(_ text: String) {
        UIPasteboard.general.string = text
    }
}
#endif


extension UserDefaults {
    
    private enum Key {
        static let firstLaunch = "AppsFirstLaunch"
    }
    
    class var firstLaunch: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: Key.firstLaunch)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.firstLaunch)
        }
    }
}
