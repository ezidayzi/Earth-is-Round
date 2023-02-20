import ProjectDescription

public extension ProjectDescription.Path {
    static func relativeToFeature(_ path: String) -> Self {
        return .relativeToRoot("Projects/iOSApp/Features/\(path)")
    }
    static func relativeToCore(_ path: String) -> Self {
        return .relativeToRoot("Projects/Core/\(path)")
    }
    static func relativeToShared(_ path: String) -> Self {
        return .relativeToRoot("Projects/Shared/\(path)")
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
}

public extension TargetDependency {
    static func feature(name: String) -> Self {
        return .project(target: name, path: .relativeToFeature(name))
    }
    static func designSystem(name: String) -> Self {
        return .project(target: name, path: .relativeToDesignSystem(name))
    }
    static func core(name: String) -> Self {
        return .project(target: name, path: .relativeToCore(name))
    }
    static func shared(name: String) -> Self {
        return .project(target: name, path: .relativeToShared(name))
    }
}
