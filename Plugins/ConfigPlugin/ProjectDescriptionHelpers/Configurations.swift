import Foundation
import ProjectDescription

public struct XCConfig {
    private struct Path {
        static var framework: ProjectDescription.Path { .relativeToRoot("xcconfigs/targets/iOS-Framework.xcconfig") }
        static var demo: ProjectDescription.Path { .relativeToRoot("xcconfigs/targets/iOS-Demo.xcconfig") }
        static var tests: ProjectDescription.Path { .relativeToRoot("xcconfigs/targets/iOS-Tests.xcconfig") }
        static func project(_ config: String) -> ProjectDescription.Path { .relativeToRoot("xcconfigs/Base/Projects/Project-\(config).xcconfig") }
    }
    
    public static let framework: [Configuration] = [
        .debug(name: "DEV", xcconfig: Path.framework),
        .debug(name: "TEST", xcconfig: Path.framework),
        .release(name: "QA", xcconfig: Path.framework),
        .release(name: "PROD", xcconfig: Path.framework),
    ]
    
    public static let tests: [Configuration] = [
        .debug(name: "DEV", xcconfig: Path.tests),
        .debug(name: "TEST", xcconfig: Path.tests),
        .release(name: "QA", xcconfig: Path.tests),
        .release(name: "PROD", xcconfig: Path.tests),
    ]
    public static let demo: [Configuration] = [
        .debug(name: "DEV", xcconfig: Path.demo),
        .debug(name: "TEST", xcconfig: Path.demo),
        .release(name: "QA", xcconfig: Path.demo),
        .release(name: "PROD", xcconfig: Path.demo),
    ]
    public static let project: [Configuration] = [
        .debug(name: "DEV", xcconfig: Path.project("DEV")),
        .debug(name: "TEST", xcconfig: Path.project("TEST")),
        .release(name: "QA", xcconfig: Path.project("QA")),
        .release(name: "PROD", xcconfig: Path.project("PROD")),
    ]
}


public struct DemoTargetOption {
    public let bundleId: String?
    
    public init(bundleId: String? = nil) {
        self.bundleId = bundleId
    }
}
