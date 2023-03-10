import ComposableArchitecture

import PedometerClient_ios

public struct MainFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        var steps: Int?
        public init() {}
    }
    
    public enum Action: Equatable {
        // View Actions
        case onAppear
        
        // Internal Actions
        case _fetchSteps(Int)
        case _showFetchingStepError
        
        // Delegate
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case checkTodayPopup
        }
    }
    
    @Dependency(\.pedometerClient)
    var pedometerClient
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    do {
                        for try await steps in pedometerClient.startFetchingSteps() {
                            await send(._fetchSteps(steps))
                        }
                    } catch {
                        await send(._showFetchingStepError)
                    }
                }
                
            case ._fetchSteps(let steps):
                state.steps = steps
                return .none
                
            case ._showFetchingStepError:
                state.steps = nil
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
}
