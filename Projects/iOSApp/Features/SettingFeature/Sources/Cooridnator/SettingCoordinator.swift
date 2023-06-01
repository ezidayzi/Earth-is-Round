//
//  SettingCoordinator.swift
//  SettingFeature
//
//  Created by Junho Lee on 2023/05/26.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import SwiftUI

import ComposableArchitecture
import TCACoordinators

public struct SettingCoordinator: ReducerProtocol {
    public init() { }
    
    public struct State: Equatable, IndexedRouterState {
        public init() {
            self.routes = [.root(.setting(.init()))]
        }
        
        public var routes: [Route<SettingScreen.State>]
    }
    
    public enum Action: IndexedRouterAction {
        case routeAction(Int, action: SettingScreen.Action)
        case updateRoutes([Route<SettingScreen.State>])
    }
    
    public var body: some ReducerProtocol<State, Action> {
        return Reduce<State, Action> { state, action in
            switch action {
            case let .routeAction(_, .setting(settingAction)):
                switch settingAction {
                case .coordinator(.pushPasswordEdit):
                    state.routes.push(.passwordEdit(.init()))
                    
                case .coordinator(.pushNicknameEdit):
                    state.routes.push(.nicknameEdit(.init()))
                    
                default: return .none
                }
                
            case let .routeAction(_, .nicknameEdit(nicknameAction)):
                switch nicknameAction {
                case .coordinator(.pop):
                    state.routes.pop()
                    
                default: return .none
                }
                
            case let .routeAction(_, .passwordEdit(passwordAction)):
                switch passwordAction {
                case .coordinator(.pop):
                    state.routes.pop()
                    
                default: return .none
                }
                
            default: break
            }
            
            return .none
        }.forEachRoute {
            SettingScreen()
        }
    }
}

