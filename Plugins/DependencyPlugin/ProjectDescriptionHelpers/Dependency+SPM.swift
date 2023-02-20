import ProjectDescription

public extension Dep {
    public struct SPM {
        public struct Local {}
        public struct External {}
    }
}

public extension Package {
    public struct SPM {
        public struct Local {}
        public struct External {}
    }
}

// MARK: - Local
public extension Dep.SPM.Local {
    
}

public extension Package.SPM.Local {
    
}

// MARK: - Third Party
public extension Dep.SPM.External {
    static let Alamofire = TargetDependency.external(name: "Alamofire")
    static let TCA = TargetDependency.external(name: "ComposableArchitecture")
    
    // Tests
    static let Nimble = TargetDependency.external(name: "Nimble")
    static let Quick = TargetDependency.external(name: "Quick")
}

public extension Package.SPM.External {
    static let Alamofire = Package.remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.6.1"))
    static let TCA = Package.remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "0.5.0"))
    
    static let Nimble = Package.remote(url: "https://github.com/Quick/Nimble.git", requirement: .upToNextMajor(from: "10.0.0"))
    static let Quick = Package.remote(url: "https://github.com/Quick/Quick.git", requirement: .upToNextMajor(from: "5.0.0"))
}
