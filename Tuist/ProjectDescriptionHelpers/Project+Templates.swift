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
                          platforms: [Platform] = [Platform.iOS],
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
        var singlePlatform = platforms.first!
        var singleDeplymentTarget = singlePlatform == .iOS
        ? DeploymentTarget.iOS(targetVersion: "15.0", devices: [.iphone])
        : DeploymentTarget.watchOS(targetVersion: "8.0")
        
        var projectTargets: [Target] = []
        var schemes: [Scheme] = []
        
        // MARK: - Interface of Feature
        // Interface는 OS별로 중복되지 않기 때문에 platform별 분기를 하지 않음
        
        if targets.contains(.interface) {
            let settings: SettingsDictionary = ["OTHER_LDFLAGS" : "$(inherited) -all_load"].merging(SettingsDictionary().setCodeSignManual())

            let target =  Target(
                    name: "\(name)Interface",
                    platform: singlePlatform,
                    product: .framework,
                    bundleId: "com.earthIsRound.\(name)Interface",
                    deploymentTarget: singleDeplymentTarget,
                    infoPlist: .default,
                    sources: ["Interface/Sources/**/*.swift"],
                    dependencies: interfaceDependencies,
                    settings: .settings(base: settings, configurations: XCConfig.framework)
                )
            
            projectTargets.append(target)
        }
        
        for platform in platforms {
            let deploymentTarget = platform == .iOS
            ? DeploymentTarget.iOS(targetVersion: "15.0", devices: [.iphone])
            : DeploymentTarget.watchOS(targetVersion: "8.0")
            
            var nameWithPlatform = platform == .iOS
            ? name + "_ios"
            : name + "_watchos"
            
            var bundleNameWithPlatform = platform == .iOS
            ? name + "-ios"
            : name + "-watchos"
            
            let originInternalDependnecies = internalDependencies
            var internalDependencies = platform == .iOS
            ? internalDependencies.filter { !$0.isWatchOSDependency }
            : internalDependencies.filter { $0.isWatchOSDependency }
            
            if platforms.count == 1 {
                nameWithPlatform = name
                bundleNameWithPlatform = name
                internalDependencies = originInternalDependnecies
            }
            
            // MARK: - Static Or Dynamic Framework
            
            if targets.contains(where: { $0.hasFramework }) {
                let deps: [TargetDependency] = targets.contains(.interface)
                ? [.target(name: "\(nameWithPlatform)Interface")]
                : []

                let settings: SettingsDictionary = hasDynamicFramework
                ? ["OTHER_LDFLAGS" : "$(inherited) -all_load"].merging(SettingsDictionary().setCodeSignManual())
                : ["OTHER_LDFLAGS" : "$(inherited)"].merging(SettingsDictionary().setCodeSignManual())
                
                let target = Target(
                    name: nameWithPlatform,
                    platform: platform,
                    product: hasDynamicFramework ? .framework : .staticFramework,
                    bundleId: "com.earthIsRound.\(bundleNameWithPlatform)",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .default,
                    sources: ["Sources/**/*.swift"],
                    resources:  hasDynamicFramework ? [.glob(pattern: "Resources/**", excluding: [])] : [],
                    dependencies: deps + internalDependencies + externalDependencies,
                    settings: .settings(base: settings, configurations: XCConfig.framework)
                )
                
                projectTargets.append(target)
            }
            
            // MARK: - Extra Target For Testing
            
            if targets.contains(.testing) {
                let target = Target(
                    name: "\(nameWithPlatform)Testing",
                    platform: platform,
                    product: .framework,
                    bundleId: "com.earthIsRound.\(bundleNameWithPlatform)Testing",
                    deploymentTarget: deploymentTarget,
                    infoPlist: .default,
                    sources: ["Testing/Sources/**/*.swift"],
                    resources: [.glob(pattern: "Testing/Resources/**", excluding: [])],
                    dependencies: [
                        testingDependencies,
                        [
                            .target(name: "\(nameWithPlatform)"),
                        ]
                    ].flatMap { $0 },
                    settings: .settings(base: SettingsDictionary().setCodeSignManual(), configurations: XCConfig.framework)
                )
                
                projectTargets.append(target)
            }
            
            // MARK: - Feature Excutable
            
            if targets.contains(.demo) {
                let deps: [TargetDependency]
                switch (hasDynamicFramework, targets.contains(.testing)) {
                case (true, true): deps = [.target(name: nameWithPlatform), .target(name: "\(nameWithPlatform)Testing")]
                case (false, true): deps = [.target(name: "\(nameWithPlatform)Testing")]
                case (_, false): deps = [.target(name: nameWithPlatform)]
                }
                
                let bundleId = demoTargetOption?.bundleId ?? "com.earthIsRound.demo.\(bundleNameWithPlatform)Demo"
                let target = Target(
                    name: "\(nameWithPlatform)Demo",
                    platform: platform,
                    product: .app,
                    bundleId: bundleId,
                    deploymentTarget: deploymentTarget,
                    infoPlist: .extendingDefault(with: Project.demoInfoPlist),
                    sources: ["Demo/Sources/**/*.swift"],
                    resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
                    dependencies: [
                        deps,
                        [
                            Dep.SPM.External.FLEX
                        ],
                    ].flatMap { $0 },
                    settings: .settings(base: SettingsDictionary().setCodeSignManual(), configurations: XCConfig.demo)
                )
                
                projectTargets.append(target)
            }
            
            // MARK: - Unit Tests
            
            if targets.contains(.unitTest) {
                let deps: [TargetDependency]
                switch (hasDynamicFramework, targets.contains(.testing), targets.contains(.demo)) {
                case (true, true, true):
                    deps = [.target(name: nameWithPlatform), .target(name: "\(nameWithPlatform)Testing"), .target(name: "\(nameWithPlatform)Demo")]
                case (true, true, false):
                    deps = [.target(name: nameWithPlatform), .target(name: "\(nameWithPlatform)Testing")]
                case (true, false, true):
                    deps = [.target(name: nameWithPlatform), .target(name: "\(nameWithPlatform)Demo")]
                case (false, true, true):
                    deps = [.target(name: "\(nameWithPlatform)Testing"), .target(name: "\(nameWithPlatform)Demo")]
                case (false, true, false):
                    deps = [.target(name: "\(nameWithPlatform)Testing")]
                case (false, false, true):
                    deps = [.target(name: "\(nameWithPlatform)Demo")]
                case (true, false, false), (false, false, false):
                    deps = [.target(name: nameWithPlatform)]
                }
                
                let target = Target(
                    name: "\(nameWithPlatform)Tests",
                    platform: platform,
                    product: .unitTests,
                    bundleId: "com.erathIsRound.\(bundleNameWithPlatform)Tests",
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
                    settings: .settings(base: SettingsDictionary().setCodeSignManual(), configurations: XCConfig.tests)
                )
                
                projectTargets.append(target)
            }
            
            // MARK: - Schemes
            
            var additionalSchemes = targets.contains(.demo)
            ? [Scheme.makeScheme(configs: configurationName, name: nameWithPlatform),
               Scheme.makeDemoScheme(configs: configurationName, name: nameWithPlatform)]
            : [Scheme.makeScheme(configs: configurationName, name: nameWithPlatform)]
            schemes += additionalSchemes
        }
        
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
            name: "\(name)Demo",
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
