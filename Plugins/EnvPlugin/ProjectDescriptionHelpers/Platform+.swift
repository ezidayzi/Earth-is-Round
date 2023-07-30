import ProjectDescription

public extension Platform {
    var deploymentTarget: DeploymentTarget {
        switch self {
        case .watchOS:
            return Const.watchDeploymentTarget
        default: // .iOS, .macOS, .tvOS
            return Const.iphoneDeploymentTarget
        }
    }

    func nameWithPlatform(_ name: String) -> String {
        switch self {
        case .watchOS:
            return name + "_watchos"
        default:
            return name + "_ios"
        }
    }

    func bundleNameWithPlatform(_ name: String) -> String {
        switch self {
        case .watchOS:
            return name + "-watchos"
        default:
            return name + "-ios"
        }
    }

    func filterDependencies(_ dependencies: [TargetDependency]) -> [TargetDependency] {
        switch self {
        case .watchOS:
            return dependencies.filter { $0.isWatchOSDependency }
        default:
            return dependencies.filter { !$0.isWatchOSDependency }
        }
    }
}

public extension TargetDependency {
    public var isWatchOSDependency: Bool {
        switch self {
        case .target(let name), .project(let name, _):
            return name.contains("_ios")
            ? false
            : true
        default:
            return true
        }
    }
}
