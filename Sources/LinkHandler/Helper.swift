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

    public var getTextFromClipboard: String? {
        UIPasteboard.general.string
    }
}
#endif


extension UserDefaults {
    
    private enum Key {
        static let firstLaunch = "AppsFirstLaunch"
    }
    
    class var firstLaunch: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Key.firstLaunch)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.firstLaunch)
        }
    }
}
