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
            ERTextField(text: $text, isValid: isValid, maxLength: 10, placeholder: "Enter text")
                .padding()
            Text("Text: \(text)")
            Toggle(isOn: $isValid) {
                Text("토글")
            }
            
            ERSpeechBalloon(text: {
                Text("머리 조금만 더 크게 만들어주지..")
            }, color: .blue)
            .padding(.horizontal, 60)
            .frame(maxHeight: 108)
            
            Spacer()
                .frame(height: 200)
            
            WeeklyWalkView(steps: [2030, 15420, 31200, 4030, 304, 132], standard: 5000)
                .background(Color.yellow)
        }
    }
}

struct SnowmanContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                SnowSet(item: [0, 3, 5, 13, 16])
                
                SnowSet(item: [0, 4, 6, 8, 12, 14])
                
                SnowSet(item: [0, 4, 7, 13, 17])
                
                SnowSet(item: [0, 1, 3, 15, 18])
                
                SnowSet(item: [0, 2])
                
                ForEach(0..<18) { item in
                    SnowSet(item: [item])
                }
            }
        }
        .padding()
        .background(Color.blue.opacity(0.2))
    }
    
    @ViewBuilder
    private func SnowSet(item: [Int]) -> some View {
        HStack {
            SnowmanView(
                itemRawValues: item,
                snowmanType: .largeHeadLargeBody
            )
            .frame(width: 50)
            .frame(height: 50 * 4/3)
            
            SnowmanView(
                itemRawValues: item,
                snowmanType: .smallHeadLargeBody
            )
            .frame(width: 50)
            .frame(height: 50 * 4/3)
            
            SnowmanView(
                itemRawValues: item,
                snowmanType: .largeHeadSmallBody
            )
            .frame(width: 50)
            .frame(height: 50 * 4/3)
            
            SnowmanView(
                itemRawValues: item,
                snowmanType: .smallHeadSmallBody
            )
            .frame(width: 50)
            .frame(height: 50 * 4/3)
        }
    }
}

struct DesignSystemDemoApp_Previews: PreviewProvider {
    static var previews: some View {
        SnowmanContentView()
    }
}
