import SwiftUI

import Alamofire

@main
struct EarthIsRoundApp: App {
    var body: some Scene {
        WindowGroup {
            Text("하이")
                .task {
                    Task {
                        print(AF)
                    }
                }
        }
    }
}
