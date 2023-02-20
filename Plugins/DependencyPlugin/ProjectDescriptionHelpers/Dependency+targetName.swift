import ProjectDescription

public extension Dep {
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
