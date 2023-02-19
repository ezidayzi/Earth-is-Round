import Foundation
import ProjectDescription

public enum FeatureTarget {
    // Feature Interface
    case interface
    // dynamicFramework / staticFramework는 둘 중 하나만 사용
    case dynamicFramework 
    case staticFramework
    // Main Excutable Test
    case testing
    // Unit Test
    case unitTest
    // Feature Excutable Test
    case demo

    public var hasFramework: Bool {
        switch self {
        case .dynamicFramework, .staticFramework: return true
        default: return false
        }
    }
    public var hasDynamicFramework: Bool { return self == .dynamicFramework }
}
