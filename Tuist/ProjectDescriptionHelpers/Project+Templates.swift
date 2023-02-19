import Foundation
import ProjectDescription

import DependencyPlugin
import ConfigPlugin
import EnvPlugin

// TODO: - CI 적용할 때 사용
let isCI = (ProcessInfo.processInfo.environment["TUIST_CI"] ?? "0") == "1" ? true : false

public extension Project {
    static func framework(name: String,
                          organizationName: String = Environment.organizationName,
                          deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "15.0", devices: .iphone),
                          targets: Set<FeatureTarget> = Set([.staticFramework, .unitTest, .demo, .testing]),
                          packages: [Package] = [],
                          internalDependencies: [TargetDependency] = [],
                          externalDependencies: [TargetDependency] = [],
                          interfaceDependencies: [TargetDependency] = [], // feature interface dependency
                          testingDependencies: [TargetDependency] = [], // dependency of extra target for testing
                          demoDependencies: [TargetDependency] = [], // feature demo excutable dependency
                          demoTargetOption: DemoTargetOption? = nil) -> Project {
        
        let hasDynamicFramework = targets.contains(.dynamicFramework)
        let configurationName: ConfigurationName = "Development"
        
        var projectTargets: [Target] = []
        
        // MARK: - Static Or Dynamic Framework
        
        if targets.contains(where: { $0.hasFramework }) {
            let settings: SettingsDictionary = hasDynamicFramework
            ? ["OTHER_LDFLAGS" : "$(inherited) -all_load"]
            : ["OTHER_LDFLAGS" : "$(inherited)"]
            
            let target = Target(
                name: name,
                platform: .iOS,
                product: hasDynamicFramework ? .framework : .staticLibrary,
                bundleId: "com.earthIsRound.\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Sources/**/*.swift"],
                resources:  hasDynamicFramework ? [.glob(pattern: "Resources/**", excluding: [])] : [],
                dependencies: internalDependencies + externalDependencies,
                settings: .settings(base: settings, configurations: XCConfig.framework)
            )
            
            projectTargets.append(target)
        }
        
        // MARK: - Interface of Feature
        
        if targets.contains(.interface) {
            let target =  Target(
                    name: "\(name)Interface",
                    platform: .iOS,
                    product: .framework,
                    bundleId: "com.earthIsRound.\(name)Interface",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .default,
                    sources: ["Interface/Sources/**/*.swift"],
                    dependencies: interfaceDependencies,
                    settings: .settings(base: [:], configurations: XCConfig.framework)
                )
            
            projectTargets.append(target)
        }
        
        // MARK: - Extra Target For Testing
        
        if targets.contains(.testing) {
            let target = Target(
                name: "\(name)Testing",
                platform: .iOS,
                product: .framework,
                bundleId: "com.earthIsRound.\(name)Testing",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Testing/Sources/**/*.swift"],
                resources: [.glob(pattern: "Testing/Resources/**", excluding: [])],
                dependencies: [
                    testingDependencies,
                    [
                        .target(name: "\(name)"),
                    ]
                ].flatMap { $0 },
                settings: .settings(base: [:], configurations: XCConfig.framework)
            )
            
            projectTargets.append(target)
        }
        
        // MARK: - Feature Excutable
        
        if targets.contains(.demo) {
            let deps: [TargetDependency]
            switch (hasDynamicFramework, targets.contains(.testing)) {
            case (true, true): deps = [.target(name: name), .target(name: "\(name)Testing")]
            case (false, true): deps = [.target(name: "\(name)Testing")]
            case (_, false): deps = [.target(name: name)]
            }
            
            let bundleId = demoTargetOption?.bundleId ?? "com.earthIsRound.demo.\(name)Demo"
            let target = Target(
                name: "\(name)Demo",
                platform: .iOS,
                product: .app,
                bundleId: bundleId,
                deploymentTarget: deploymentTarget,
                infoPlist: .extendingDefault(with: Project.demoInfoPlist),
                sources: ["Demo/Sources/**/*.swift"],
                resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
                dependencies: [
                    deps,
                    [
                        // MARK: DEV Tool 추가
                    ],
                ].flatMap { $0 },
                settings: .settings(base: [:], configurations: XCConfig.demo)
            )
            
            projectTargets.append(target)
        }
        
        // MARK: - Unit Tests
        
        if targets.contains(.unitTest) {
            let deps: [TargetDependency]
            switch (hasDynamicFramework, targets.contains(.testing), targets.contains(.demo)) {
            case (true, true, true):
                deps = [.target(name: name), .target(name: "\(name)Testing"), .target(name: "\(name)Demo")]
            case (true, true, false):
                deps = [.target(name: name), .target(name: "\(name)Testing")]
            case (true, false, true):
                deps = [.target(name: name), .target(name: "\(name)Demo")]
            case (false, true, true):
                deps = [.target(name: "\(name)Testing"), .target(name: "\(name)Demo")]
            case (false, true, false):
                deps = [.target(name: "\(name)Testing")]
            case (false, false, true):
                deps = [.target(name: "\(name)Demo")]
            case (true, false, false), (false, false, false):
                deps = [.target(name: name)]
            }
            
            let target = Target(
                name: "\(name)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: "com.erathIsRound.\(name)Tests",
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

        let schemes: [Scheme] = targets.contains(.demo)
        ? [.makeScheme(configs: configurationName, name: name)]
        : [.makeScheme(configs: configurationName, name: name),
         .makeDemoScheme(configs: configurationName, name: name)]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: .settings(configurations: XCConfig.project),
            targets: projectTargets,
            schemes: schemes,
            additionalFiles: ["README.md"])
    }
}

extension Scheme {
    static func makeScheme(configs: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: configs,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: configs),
            archiveAction: .archiveAction(configuration: configs),
            profileAction: .profileAction(configuration: configs),
            analyzeAction: .analyzeAction(configuration: configs)
        )
    }
    static func makeDemoScheme(configs: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)Demo"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: configs,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)Demo"])
            ),
            runAction: .runAction(configuration: configs),
            archiveAction: .archiveAction(configuration: configs),
            profileAction: .profileAction(configuration: configs),
            analyzeAction: .analyzeAction(configuration: configs)
        )
    }
}
