import ComposableArchitecture
import Dependencies
import Shared_ios
import PushNotificationClient_ios

public struct SettingFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        // View Actions
        case naviBackButtonTapped
        case nicknameEditTapped
        case passwordEditTapped
        case logoutTapped
        
        // Internal Actions
        
        // Coordinator
        case coordinator(CoordinatorAction)
        
        public enum CoordinatorAction {
            case pop
            case pushNicknameEdit
            case pushPasswordEdit
            case toSplash
        }
    }

    @Dependency(\.pushNotificationClient)
    var pushNotificationClient

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .nicknameEditTapped:
                return .send(.coordinator(.pushNicknameEdit))
                
            case .passwordEditTapped:
                return .send(.coordinator(.pushPasswordEdit))
                
            case .naviBackButtonTapped:
                return .send(.coordinator(.pop))

            case .logoutTapped:
                KeychainClient.deleteAll()
                pushNotificationClient.cancelNotificationsScheduling(PushNotificationType.allCases)
                return .send(.coordinator(.toSplash))
                
            case .coordinator:
                return .none

            }
        }
    }
}
