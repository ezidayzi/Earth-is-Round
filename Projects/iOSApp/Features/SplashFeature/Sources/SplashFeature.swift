import APIClient_ios
import ComposableArchitecture
import Dependencies
import Foundation
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

        // Inner Actions
        case _successSignIn
        case _failureSignIn

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

    @Dependency(\.userAPI)
    var userAPI

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .splashAnimationFinished:
                return requestLogin()
            case ._successSignIn:
                return .concatenate(
                    requestPushNotificationClientAuth(),
                    schdulePushNotification(),
                    .send(.coordinator(.toMain))
                )
            case ._failureSignIn:
                return .concatenate(
                    requestPushNotificationClientAuth(),
                    schdulePushNotification(),
                    .send(.coordinator(.toAuth))
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

    private func requestPushNotificationClientAuth() -> EffectTask<Action> {
        .run { send in
            let result = try await pushNotificationClient.requestAuthorization()
            print(result)
        }
    }

    private func requestLogin() -> EffectTask<Action> {
        .run { send in
            guard
                let nickname = KeychainClient.nickname,
                let password = KeychainClient.password,
                !nickname.isEmpty,
                !password.isEmpty
            else {
                await send(._failureSignIn)
                return
            }
            let result = await userAPI.login(nickname, password)

            switch result {
            case .success(let loginResponse):
                print("Login Response: \(loginResponse)")
                KeychainClient.token = loginResponse.token
                KeychainClient.nickname = loginResponse.nickname
                await send(._successSignIn)
            case .failure(let failure as ErrorCode):
                print("Login Failure: \(failure.description)")
                await send(._failureSignIn)
            case .failure:
                await send(._failureSignIn)
            }
        }
    }
}
