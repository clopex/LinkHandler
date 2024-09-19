//
//  README.md
//  LinkHandler
//
//  Created by Adis Mulabdic on 19. 9. 2024..
//

# LinkHandler
## Simple SPM for handling universal links and to get data from clipboard or from cookie

------

# How to use

Import `LinkHandler`

## SceneDelegate (UIKit) implementation
```
func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard let incomingURL = userActivity.webpageURL else { return }
        
        Task {
            let resolvedLink = LinkHandler()
            if let resolvedLink = await resolvedLink.handleIncomingLink(incomingURL) {
                await routeTo(resolved: resolvedLink)
            }
        }
    }
    
    private func routeTo(resolved: ResolvedLink) async {
        print("Received path: \(resolved.path)")
        print("Query parameters: \(resolved.queryParameters)")
        print("Query parameters: \(resolved.url)")
        print("Query parameters: \(resolved.copiedData)")
    }
```

## SwiftUI Implementation

```
@main
struct Test3App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    Task {
                        await handleUrl(url: url)
                    }
                }
        }
    }
    
    private func handleUrl(url: URL) async {
        Task {
            let resolvedLink = LinkHandler()
            if let resolvedLink = await resolvedLink.handleIncomingLink(url) {
                await routeTo(resolved: resolvedLink)
            }
        }
    }
    
    private func routeTo(resolved: ResolvedLink) async {
        print("Received path: \(resolved.path)")
        print("Query parameters: \(resolved.queryParameters)")
        print("Query parameters: \(resolved.url)")
        print("Query parameters: \(resolved.copiedData)")
    }
    
}
```

If we want to use data from cookies instead Clipboard we shold initilaze LinkHandler as
`let resolvedLink = LinkHandler(option: .cookies(name: nameOfCookie))`

We need to pass the name of the cookie that we expect to have a value.




