import ProjectDescription

public extension TargetDependency {
    public struct Features {
        public struct Splash {}
        public struct Main {}
        public struct Auth {}
        public struct Archive {}
        public struct Setting {}
        public struct SnowmanAlert {}
        public struct ItemAlert {}
    }
    public struct Watch {
        public struct Features {
            public struct WatchMain {}
        }
    }
    public struct Domain {}
    public struct Core {
        public struct PedometerClient {}
        public struct HealthClient {}
        public struct LocationClient {}
        public struct APIClient {}
        public struct LocalStorageClient {}
        public struct PushNotificationClient {}
    }
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

public extension Dep.Features.Auth {
    static let group = "Auth"
    static func project(name: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToFeature("\(group)\(name)")) }

    static let Feature        = project(name: "Feature")
    static let Interface = Dep.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

public extension Dep.Features.Archive {
    static let group = "Archive"
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

public extension Dep.Features.SnowmanAlert {
    static let group = "SnowmanAlert"
    static func project(name: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToFeature("\(group)\(name)")) }

    static let Feature        = project(name: "Feature")
    static let Interface = Dep.project(target: "\(group)FeatureInterface", path: .relativeToFeature("\(group)Feature"))
}

public extension Dep.Features.ItemAlert {
    static let group = "ItemAlert"
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

public extension Dep.Core.PedometerClient {
    static let iOS = Dep.project(target: "PedometerClient_ios", path: .relativeToCore("PedometerClient"))
    static let watchOS = Dep.project(target: "PedometerClient_watchos", path: .relativeToCore("PedometerClient"))
}

public extension Dep.Core.APIClient {
    static let iOS = Dep.project(target: "APIClient_ios", path: .relativeToCore("APIClient"))
    static let watchOS = Dep.project(target: "APIClient_watchos", path: .relativeToCore("APIClient"))
}

public extension Dep.Core.HealthClient {
    static let iOS = Dep.project(target: "HealthClient_ios", path: .relativeToCore("HealthClient"))
    static let watchOS = Dep.project(target: "HealthClient_watchos", path: .relativeToCore("HealthClient"))
}

public extension Dep.Core.LocationClient {
    static let iOS = Dep.project(target: "LocationClient_ios", path: .relativeToCore("LocationClient"))
    static let watchOS = Dep.project(target: "LocationClient_watchos", path: .relativeToCore("LocationClient"))
}

public extension Dep.Core.LocalStorageClient {
    static let iOS = Dep.project(target: "LocalStorageClient_ios", path: .relativeToCore("LocalStorageClient"))
    static let watchOS = Dep.project(target: "LocalStorageClient_watchos", path: .relativeToCore("LocalStorageClient"))
}

public extension Dep.Core.PushNotificationClient {
    static let iOS = Dep.project(target: "PushNotificationClient_ios", path: .relativeToCore("PushNotificationClient"))
    static let watchOS = Dep.project(target: "PushNotificationClient_watchos", path: .relativeToCore("PushNotificationClient"))
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
