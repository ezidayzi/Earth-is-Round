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
    static let TCACoordinator = TargetDependency.external(name: "TCACoordinators")
    static let Lottie = TargetDependency.external(name: "Lottie")
    static let RealmSwift = TargetDependency.external(name: "RealmSwift")
    
    // Demo
    static let FLEX = TargetDependency.external(name: "FLEX")
    
    // Tests
    static let Nimble = TargetDependency.external(name: "Nimble")
    static let Quick = TargetDependency.external(name: "Quick")
}

public extension Package.SPM.External {
    static let Alamofire = Package.remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.6.1"))
    static let TCA = Package.remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "0.57.0"))
    static let TCACoordinator = Package.remote(url: "https://github.com/johnpatrickmorgan/TCACoordinators.git", requirement: .branch("tca-release/0.57.0"))
    static let Lottie = Package.remote(url: "https://github.com/airbnb/lottie-ios", requirement: .upToNextMajor(from: "3.0.0"))
    
    static let FLEX = Package.remote(url: "https://github.com/FLEXTool/FLEX.git", requirement: .upToNextMajor(from: "4.3.0"))
    
    static let Nimble = Package.remote(url: "https://github.com/Quick/Nimble.git", requirement: .upToNextMajor(from: "10.0.0"))
    static let Quick = Package.remote(url: "https://github.com/Quick/Quick.git", requirement: .upToNextMajor(from: "5.0.0"))
    static let RealmSwift = Package.remote(url: "https://github.com/realm/realm-swift", requirement: .upToNextMajor(from: "10.40.0"))
}
