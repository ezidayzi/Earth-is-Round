import Foundation
import ProjectDescription

import DependencyPlugin
import ConfigPlugin
import EnvPlugin

public extension Project {
    static func iOSApp(
        name: String,
        organizationName: String = Const.workspaceName,
        targets: Set<FeatureTarget> = Set([.staticFramework, .unitTest, .demo, .testing]),
        entitlements: Path? = nil,
        packages: [Package] = [],
        internalDependencies: [TargetDependency] = [],
        externalDependencies: [TargetDependency] = [],
        testingDependencies: [TargetDependency] = [] // dependency of extra target for testing
    ) -> Project {
        
        let deploymentTarget = Const.iphoneDeploymentTarget
        var projectTargets: [Target] = []
        
        let settings: SettingsDictionary = .baseSettings.setCodeSignManual()
        
        let target = Target(
            name: name,
            platform: .iOS,
            product: .app,
            bundleId: "\(Const.bundlePrefix).release",
            deploymentTarget: deploymentTarget,
            infoPlist: .extendingDefault(with: Project.iosAppInfoPlist),
            sources: ["Sources/**/*.swift"],
            resources:  [.glob(pattern: "Resources/**", excluding: [])],
            entitlements: entitlements,
            dependencies: [
                internalDependencies,
                externalDependencies,
                [
                    Dep.project(target: "EarthIsRoundWatchApp", path: .watchApp),
                    Dep.target(name: "WidgetExtension")
                ]
            ].flatMap { $0 },
            settings: .settings(base: settings.setProvisioning(), configurations: XCConfig.project)
        )
        
        projectTargets.append(target)
        
        // MARK: - Testing: Extra Target For Testing
        
        if targets.contains(.testing) {
            let target = Target(
                name: "\(name)Testing",
                platform: .iOS,
                product: .framework,
                bundleId: "\(Const.bundlePrefix).\(name)Testing",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Testing/Sources/**/*.swift"],
                resources: [.glob(pattern: "Testing/Resources/**", excluding: [])],
                dependencies: [
                    testingDependencies,
                ].flatMap { $0 },
                settings: .settings(base: settings, configurations: XCConfig.framework)
            )
            
            projectTargets.append(target)
        }
        
        // MARK: - Widget Extension
        
        let widgetTarget = Target(
            name: "WidgetExtension",
            platform: .iOS,
            product: .appExtension,
            bundleId: "\(Const.bundlePrefix).release.widget",
            infoPlist: .extendingDefault(with: widgetInfoPlist),
            sources: "../Extensions/WidgetExtension/Sources/**/*.swift",
            resources: "../Extensions/WidgetExtension/Resources/**",
            dependencies: [
                .Core.iOS
            ],
            settings: .settings(base: settings.setProvisioningWidget(), configurations: XCConfig.project)
        )
        
        projectTargets.append(widgetTarget)
        
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
                platform: .iOS,
                product: .unitTests,
                bundleId: "\(Const.bundlePrefix).Tests",
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
                settings: .settings(base: settings, configurations: XCConfig.tests)
            )
            
            projectTargets.append(target)
        }
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: .settings(configurations: XCConfig.project),
            targets: projectTargets,
            schemes: appSchemes,
            additionalFiles: []
        )
    }
}

extension Project {
    static let appSchemes: [Scheme] = [
        .init(
            name: "EarthIsRound-DEV",
            shared: true,
            buildAction: .buildAction(targets: ["EarthIsRound"]),
            runAction: .runAction(configuration: "Development"),
            archiveAction: .archiveAction(configuration: "Development"),
            profileAction: .profileAction(configuration: "Development"),
            analyzeAction: .analyzeAction(configuration: "Development")
        ),
        .init(
            name: "EarthIsRound-Test",
            shared: true,
            buildAction: .buildAction(targets: ["EarthIsRound"]),
            runAction: .runAction(configuration: "Test"),
            archiveAction: .archiveAction(configuration: "Test"),
            profileAction: .profileAction(configuration: "Test"),
            analyzeAction: .analyzeAction(configuration: "Test")
        ),
        .init(
            name: "EarthIsRound-QA",
            shared: true,
            buildAction: .buildAction(targets: ["EarthIsRound"]),
            runAction: .runAction(configuration: "QA"),
            archiveAction: .archiveAction(configuration: "QA"),
            profileAction: .profileAction(configuration: "QA"),
            analyzeAction: .analyzeAction(configuration: "QA")
        ),
        .init(
            name: "EarthIsRound-Release",
            shared: true,
            buildAction: .buildAction(targets: ["EarthIsRound"]),
            runAction: .runAction(configuration: "Release"),
            archiveAction: .archiveAction(configuration: "Release"),
            profileAction: .profileAction(configuration: "Release"),
            analyzeAction: .analyzeAction(configuration: "Release")
        )
    ]
}
