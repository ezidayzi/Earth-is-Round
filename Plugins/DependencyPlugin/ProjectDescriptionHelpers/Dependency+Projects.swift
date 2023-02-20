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
    public struct ThirdPartyLibs {}
    public struct DesignSystem {}
}

// MARK: - Features

public extension Dep.Features {
    static let BaseFeatureDependency = Dep.project(target: "BaseFeatureDependency", path: .relativeToFeature("BaseFeatureDependency"))
    static let RootFeature = Dep.project(target: "RootFeature", path: .relativeToFeature("RootFeature"))
}

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

public extension Dep.Core {
    static let iOS = Dep.project(target: "Core_ios", path: .core)
    static let watchOS = Dep.project(target: "Core_watchos", path: .core)
}

// MARK: - DesignSystemp

public extension Dep.DesignSystem {
    static let iOS = Dep.project(target: "DesignSystem_ios", path: .designSystem)
    static let watchOS = Dep.project(target: "DesignSystem_watchos", path: .designSystem)
}

// MARK: - Shared

public extension Dep.Shared {
    static let iOS = Dep.project(target: "Shared_ios", path: .shared)
    static let watchOS = Dep.project(target: "Shared_watchos", path: .shared)
}

// MARK: - ThirdPartyLibs

public extension Dep.ThirdPartyLibs {
    static let iOS = Dep.project(target: "ThirdPartyLibs_ios", path: .thirdPartyLibs)
    static let watchOS = Dep.project(target: "ThirdPartyLibs_watchos", path: .thirdPartyLibs)
}
