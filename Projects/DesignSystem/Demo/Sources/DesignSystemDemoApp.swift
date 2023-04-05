import SwiftUI

#if os(iOS)
import DesignSystem_ios
#elseif os(watchOS)
import DesignSystem_watchos
#endif

@main
struct DesignSystemDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var text = ""
    @State private var isValid = false
    
    var body: some View {
        VStack {
            ERTextField(text: $text, isValid: $isValid, maxLength: 10, placeholder: "Enter text")
                .padding()
            Text("Text: \(text)")
            Toggle(isOn: $isValid) {
                Text("토글")
            }
        }
    }
}

struct DesignSystemDemoApp_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
