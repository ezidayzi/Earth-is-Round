import ProjectDescription

public extension ProjectDescription.Path {
    static func relativeToFeature(_ path: String) -> Self {
        return .relativeToRoot("Projects/iOSApp/Features/\(path)")
    }
    static func relativeToCore(_ path: String) -> Self {
        return .relativeToRoot("Projects/Core/\(path)")
    }
    static func relativeToDesignSystem(_ path: String) -> Self {
        return .relativeToRoot("Projects/DesignSystem/\(path)")
    }
    static func relativeToWatchApp(_ path: String) -> Self {
        return .relativeToRoot("Projects/WatchApp/\(path)")
    }
    static var app: Self {
        return .relativeToRoot("Projects/iOSApp/Application")
    }
    static var watchApp: Self {
        return .relativeToRoot("Projects/WatchApp/Application")
    }
    static var domain: Self {
        return .relativeToRoot("Projects/Domain")
    }
    static var core: Self {
        return .relativeToRoot("Projects/Core")
    }
    static var shared: Self {
        return .relativeToRoot("Projects/Shared")
    }
    static var designSystem: Self {
        return .relativeToRoot("Projects/DesignSystem")
    }
    static var thirdPartyLibs: Self {
        return .relativeToRoot("Projects/ThirdPartyLibs")
    }
}
