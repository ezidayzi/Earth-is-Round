import ProjectDescription

public extension TargetDependency {
    public struct Features {
        public struct Splash {}
        public struct Main {}
        public struct Setting {}
    }
    public struct Watch {
        public struct Features {
            public struct WatchMain {}
        }
    }
    public struct Domain {}
    public struct Core {}
    public struct Shared {}
    public struct DesignSystem {}
}

// MARK: - Features

public extension Dep.Features.Splash {
    static let group = "Splash"
    static func project(name: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToFeature("\(group)\(name)")) }

    static let Feature        = project(name: "Feature")
    static let Interface = Dep.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

public extension Dep.Features.Main {
    static let group = "Main"
    static func project(name: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToFeature("\(group)\(name)")) }

    static let Feature        = project(name: "Feature")
    static let Interface = Dep.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

public extension Dep.Features.Setting {
    static let group = "Setting"
    static func project(name: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToFeature("\(group)\(name)")) }

    static let Feature        = project(name: "Feature")
    static let Interface = Dep.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

// MARK: - Watch

public extension Dep.Watch.Features.WatchMain {
    static let group = "WatchMain"
    static func project(name: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToWatchApp("Features/\(group)\(name)")) }

    static let Feature        = project(name: "Feature")
    static let Interface = Dep.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

// MARK: - Domain

public extension Dep.Domain {
    static let iOS = Dep.project(target: "Domain_ios", path: .domain)
    static let watchOS = Dep.project(target: "Domain_watchos", path: .domain)
}

// MARK: - Core
// MARK: - Shared
