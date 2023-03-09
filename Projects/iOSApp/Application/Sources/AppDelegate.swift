//
//  AppDelegate.swift
//  EarthIsRound
//
//  Created by Junho Lee on 2023/03/07.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import UIKit
import WatchConnectivity

import ComposableArchitecture

final class AppDelegate: UIResponder, UIApplicationDelegate {
    let store = Store<AppFeature.State, AppFeature.Action>(
        initialState: AppFeature.State(),
        reducer: AppFeature()
    )
    
    lazy var viewStore = ViewStore<AppFeature.State, AppFeature.Action>(store)
    
    var session: WCSession!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        session = WCSession.default
        
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
        
        return true
    }
}

// TODO: WatchApp 연동 세부 로직 작성

extension AppDelegate: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
    
    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {
        
    }
    
    func session(
        _ session: WCSession,
        didReceiveMessage message: [String: Any],
        replyHandler: @escaping ([String: Any]) -> Void
    ) {
        
    }
}
