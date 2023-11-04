import ComposableArchitecture
import Foundation
import Dependencies
import Shared_ios
import PushNotificationClient_ios

public struct SplashFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        // View Actions
        case splashAnimationFinished

        // Coordinator
        case coordinator(CoordinatorAction)

        public enum CoordinatorAction {
            case toAuth
            case toMain
        }
    }

    @Dependency(\.pushNotificationClient)
    var pushNotificationClient

    @Dependency(\.userDefaultsClient)
    var userDefaultsClient

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .splashAnimationFinished:
                guard
                    let lastLoginDate = userDefaultsClient.stringForKey(UserDefaultsKey.lastLoginDate).toDate()
                else {
                    return .concatenate(
                        schdulePushNotification(),
                        .send(.coordinator(.toAuth))
                    )
                }

                if let difference = Calendar.current.dateComponents([.day], from: lastLoginDate, to: Date()).day,
                   difference > 7 {
                    KeychainClient.nickname = nil
                    KeychainClient.token = nil
                }

                if KeychainClient.token == nil || KeychainClient.nickname == nil {
                    return .concatenate(
                        schdulePushNotification(),
                        .send(.coordinator(.toAuth))
                    )
                }
                return .concatenate(
                    schdulePushNotification(),
                    .send(.coordinator(.toMain))
                )
            case .coordinator:
                return .none
            }
        }
    }

    private func schdulePushNotification() -> EffectTask<Action> {
        .run { send in
            let result = await pushNotificationClient.requestNotificationsScheduling()
            switch result {
            case .success:
                return
            case .failure:
                break
                // Error 처리
            }
        }
    }
}
