import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "HealthClient",
    platforms: [.iOS, .watchOS],
    targets: [.unitTest, .dynamicFramework],
    internalDependencies: [
        .Shared.iOS,
        .Shared.watchOS,
        .sdk(name: "HealthKit", type: .framework, status: .required)
    ],
    externalDependencies: [
        
    ],
    interfaceDependencies: [
        
    ],
    testingDependencies: [],
    demoDependencies: []
)
