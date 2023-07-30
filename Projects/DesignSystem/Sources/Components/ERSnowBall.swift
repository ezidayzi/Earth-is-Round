//
//  ERSnowBall.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/06/19.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI
import Lottie

/// CADisplayLink와 Coordinator를 이용하여 animation 속도를 부드럽게 전환
public class LottieCoordinator: NSObject {
    var animationView: LottieAnimationView?
    var targetSpeed: Double = 0.0
    var displayLink: CADisplayLink?
    
    @objc func updateAnimationSpeed() {
        guard let animationView = animationView else { return }
        
        let currentSpeed = animationView.animationSpeed
        let delta = (targetSpeed - currentSpeed) * 0.1
        animationView.animationSpeed = currentSpeed + delta
        
        if abs(targetSpeed - animationView.animationSpeed) < 0.01 {
            displayLink?.invalidate()
            displayLink = nil
            animationView.animationSpeed = targetSpeed
        }
    }
}

public struct ERSnowBall: UIViewRepresentable {
    @Binding var animationSpeed: Double
    
    /// - NOTE(230725) @Duno
    /// 보통 사람의 결음 속도는 5km/h. 5km/h일 때 animationSpeed를 2로 보정하기 위한 비율
    /// 상수들 Shared에 Double 및 Int의 Extension으로 분리하는 것 고려
    private enum Metric {
        static let correctionRatio = 2.0 / 5.0
        static let secondToHour = 60.0 * 60.0
        static let meterToKilometer = 1.0 / 1000.0
        static func calculateAnimationSpeed(_ speed: Double) -> Double {
            return speed * correctionRatio * secondToHour * meterToKilometer
        }
    }
    
    public init(animationSpeed: Binding<Double>) {
        self._animationSpeed = animationSpeed
    }
    
    public func makeUIView(context: UIViewRepresentableContext<ERSnowBall>) -> some UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView()
        animationView.animationSpeed = 0
        animationView.animation = Animation.named("snowball", bundle: .module)
        
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        // background에서 복귀 후 다시 재생하기 위함
        animationView.backgroundBehavior = .pauseAndRestore
        
        context.coordinator.animationView = animationView
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    public func updateUIView(_ uiView: some UIView, context: UIViewRepresentableContext<ERSnowBall>) {
        let coordinator = context.coordinator
        // animationSpeed가 0이 되면 animation이 stop된다고 추정됨. 다시 play 하는 방법도 고려 가능
        let correctedAnimationSpeed = animationSpeed == 0 ? 0.01 : animationSpeed
        coordinator.targetSpeed = Metric.calculateAnimationSpeed(correctedAnimationSpeed)
        
        if coordinator.displayLink == nil {
            coordinator.displayLink = CADisplayLink(target: coordinator, selector: #selector(coordinator.updateAnimationSpeed))
            coordinator.displayLink?.add(to: .current, forMode: .common)
        }
    }
    
    public func makeCoordinator() -> LottieCoordinator {
        return LottieCoordinator()
    }
}
