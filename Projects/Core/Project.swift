import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "Core",
    platforms: [.iOS, .watchOS],
    targets: [.unitTest, .dynamicFramework, .demo, .testing],
    internalDependencies: [
        .Shared.iOS,
        .Shared.watchOS
    ],
    externalDependencies: [
        
    ],
    interfaceDependencies: [
        
    ],
    testingDependencies: [],
    demoDependencies: []
)
