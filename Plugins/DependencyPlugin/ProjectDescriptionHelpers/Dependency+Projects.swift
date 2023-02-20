import ProjectDescription

public extension TargetDependency {
    public struct Features {
        public struct Splash {}
        public struct Main {}
        public struct Setting {}
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

// MARK: - Domain
// MARK: - Core
// MARK: - Shared
