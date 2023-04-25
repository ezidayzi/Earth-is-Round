import Foundation
import ProjectDescription

import DependencyPlugin
import ConfigPlugin
import EnvPlugin

public extension Project {
    static func watchApp(name: String,
                         organizationName: String = Environment.workspaceName,
                         targets: Set<FeatureTarget> = Set([.staticFramework, .unitTest, .demo, .testing]),
                         packages: [Package] = [],
                         internalDependencies: [TargetDependency] = [],
                         externalDependencies: [TargetDependency] = [],
                         testingDependencies: [TargetDependency] = [] // dependency of extra target for testing
    ) -> Project {
        
        let configurationName: ConfigurationName = "Development"
        let deploymentTarget = Environment.watchDeploymentTarget
        var projectTargets: [Target] = []
        
        let settings = Project.watchAppSettings
        
        let target = Target(
            name: name,
            platform: .watchOS,
            product: .app,
            bundleId: "\(Environment.bundlePrefix).release.watchApp",
            deploymentTarget: deploymentTarget,
            infoPlist: nil,
            sources: ["Sources/**/*.swift"],
            resources:  [.glob(pattern: "Resources/**", excluding: [])],
            dependencies: internalDependencies + externalDependencies,
            settings: .settings(base: settings, configurations: XCConfig.project)
        )
        
        projectTargets.append(target)
        
        // MARK: - Testing: Extra Target For Testing
        
        if targets.contains(.testing) {
            let target = Target(
                name: "\(name)Testing",
                platform: .watchOS,
                product: .framework,
                bundleId: "\(Environment.bundlePrefix).\(name)Testing",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Testing/Sources/**/*.swift"],
                resources: [.glob(pattern: "Testing/Resources/**", excluding: [])],
                dependencies: [
                    testingDependencies
                ].flatMap { $0 },
                settings: .settings(base: [:], configurations: XCConfig.framework)
            )
            
            projectTargets.append(target)
        }
        
        // MARK: - Tests: Unit Tests
        
        if targets.contains(.unitTest) {
            let deps: [TargetDependency]
            switch (targets.contains(.testing), targets.contains(.demo)) {
            case (true, true):
                deps = [.target(name: name), .target(name: "\(name)Testing"), .target(name: "\(name)Demo")]
            case (true, false):
                deps = [.target(name: name), .target(name: "\(name)Testing")]
            case (false, true):
                deps = [.target(name: name), .target(name: "\(name)Demo")]
            case (false, false):
                deps = [.target(name: name)]
            }
            
            let target = Target(
                name: "\(name)Tests",
                platform: .watchOS,
                product: .unitTests,
                bundleId: "\(Environment.bundlePrefix).Tests",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Tests/Sources/**/*.swift"],
                resources: [.glob(pattern: "Tests/Resources/**", excluding: [])],
                dependencies: [
                    deps,
                    [
                        .SPM.External.Nimble,
                        .SPM.External.Quick
                    ]
                ].flatMap { $0 },
                settings: .settings(base: [:], configurations: XCConfig.tests)
            )
            
            projectTargets.append(target)
        }
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: .settings(configurations: XCConfig.project),
            targets: projectTargets,
            schemes: watchAppSchemes,
            additionalFiles: [])
    }
}

extension Project {
    static let watchAppSchemes: [Scheme] = [
        .init(
            name: "EarthIsRoundWatchApp-DEV",
            shared: true,
            buildAction: .buildAction(targets: ["EarthIsRoundWatchApp"]),
            runAction: .runAction(configuration: "Development"),
            archiveAction: .archiveAction(configuration: "Development"),
            profileAction: .profileAction(configuration: "Development"),
            analyzeAction: .analyzeAction(configuration: "Development")
        ),
        .init(
            name: "EarthIsRoundWatchApp-Test",
            shared: true,
            buildAction: .buildAction(targets: ["EarthIsRoundWatchApp"]),
            runAction: .runAction(configuration: "Test"),
            archiveAction: .archiveAction(configuration: "Test"),
            profileAction: .profileAction(configuration: "Test"),
            analyzeAction: .analyzeAction(configuration: "Test")
        ),
        .init(
            name: "EarthIsRoundWatchApp-QA",
            shared: true,
            buildAction: .buildAction(targets: ["EarthIsRoundWatchApp"]),
            runAction: .runAction(configuration: "QA"),
            archiveAction: .archiveAction(configuration: "QA"),
            profileAction: .profileAction(configuration: "QA"),
            analyzeAction: .analyzeAction(configuration: "QA")
        ),
        .init(
            name: "EarthIsRoundWatchApp-Release",
            shared: true,
            buildAction: .buildAction(targets: ["EarthIsRoundWatchApp"]),
            runAction: .runAction(configuration: "Release"),
            archiveAction: .archiveAction(configuration: "Release"),
            profileAction: .profileAction(configuration: "Release"),
            analyzeAction: .analyzeAction(configuration: "Release")
        )
    ]
}
