import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "WatchMainFeature",
    platforms: [.watchOS],
    targets: [.testing, .interface, .unitTest, .staticFramework, .demo],
    internalDependencies: [
        
    ],
    externalDependencies: [
        
    ],
    interfaceDependencies: [
        .Core.watchOS,
        .Domain.watchOS,
        .DesignSystem.watchOS
    ],
    testingDependencies: [],
    demoDependencies: []
)
