//
//  ERSnowBall.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/06/19.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI
import Lottie

public class LottieCoordinator: NSObject {
    var animationView: LottieAnimationView?
    var targetSpeed: CGFloat = 1.0
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
    @Binding var animationSpeed: CGFloat
    
    public init(animationSpeed: Binding<CGFloat>) {
        self._animationSpeed = animationSpeed
    }
    
    public func makeUIView(context: UIViewRepresentableContext<ERSnowBall>) -> LottieAnimationView {
        let animationView = LottieAnimationView()
        animationView.animation = Animation.named("snowball", bundle: .module)
        
        animationView.contentMode = .scaleToFill
        animationView.play()
        animationView.loopMode = .loop
        
        context.coordinator.animationView = animationView
        
        return animationView
    }
    
    public func updateUIView(_ uiView: LottieAnimationView, context: UIViewRepresentableContext<ERSnowBall>) {
        // 부드럽게 애니메이션 속도 업데이트
        let coordinator = context.coordinator
        coordinator.targetSpeed = animationSpeed
        
        if coordinator.displayLink == nil {
            coordinator.displayLink = CADisplayLink(target: coordinator, selector: #selector(coordinator.updateAnimationSpeed))
            coordinator.displayLink?.add(to: .current, forMode: .common)
        }
    }
    
    public func makeCoordinator() -> LottieCoordinator {
        return LottieCoordinator()
    }
}
