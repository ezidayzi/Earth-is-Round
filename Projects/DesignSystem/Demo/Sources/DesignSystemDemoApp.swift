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

import Combine

struct ContentView: View {
    @State private var text = ""
    @State private var isValid = false
    @State private var animationSpeed: Double = 1.0
    
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
            
            VStack {
                ERSnowBall(animationSpeed: $animationSpeed)
                    .frame(width: 200, height: 200)
                    .offset(y: bounceHeight?.associatedOffset ?? 0)
                    .scaleEffect(x: 1, y: scaleY)
                    .onLongPressGesture {

                    } onPressingChanged: { started in
                        print(started)
                        if !started {
                            bounceAnimation()
                        } else {
                            withAnimation(Animation.easeOut(duration: 0.3).delay(0)) {
                                scaleY = 0.95
                                bounceHeight = .down10
                            }
                        }
                    }

                
                Slider(value: $animationSpeed, in: 0.0...10.0, label: { Text("Speed") })
            }
            
            WeeklyWalkView(steps: [2030, 15420, 31200, 4030, 304, 132], standard: 5000)
            
            
        }.background(ERColor.White)
    }
    var cancellable = Set<AnyCancellable>()
    @State var bounceHeight: BounceHeight? = nil
    @State var scaleY: CGFloat = 1.0
    
    
    func bounceAnimation() {
        // Step 1: 살짝 아래로 찌그러짐
        withAnimation(Animation.easeOut(duration: 0.1).delay(0)) {
            scaleY = 1.0
            bounceHeight = .down10
        }
        // Step 2: 큰 점프
        withAnimation(Animation.easeOut(duration: 0.4).delay(0.4)) {
            bounceHeight = .up100
            scaleY = 1.0
        }
        // Step 3: 작은 점프로 내려옴
        withAnimation(Animation.easeIn(duration: 0.3).delay(0.7)) {
            bounceHeight = .base
        }
        // Step 4: 중간 높이로 점프
        withAnimation(Animation.easeOut(duration: 0.2).delay(1.0)) {
            bounceHeight = .up40
        }
        // Step 5: 작은 점프로 내려옴
        withAnimation(Animation.easeIn(duration: 0.2).delay(1.2)) {
            bounceHeight = .base
        }
        // Step 6: 작은 점프
        withAnimation(Animation.easeOut(duration: 0.1).delay(1.4)) {
            bounceHeight = .up10
        }
        // Step 7: 원래 위치로 돌아옴
        withAnimation(Animation.easeIn(duration: 0.1).delay(1.5)) {
            bounceHeight = .none
        }
    }
    
    enum BounceHeight {
        case down10, up100, up40, up10, base
        var associatedOffset: Double {
            switch self {
            case .down10:
                return 20
            case .up100:
                return -100
            case .up40:
                return -40
            case .up10:
                return -10
            case .base:
                return 0
            }
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
        ContentView()
    }
}
