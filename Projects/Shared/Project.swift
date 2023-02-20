import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "Shared",
    platforms: [.iOS, .watchOS],
    targets: [.unitTest, .dynamicFramework],
    internalDependencies: [
        .ThirdPartyLibs.iOS,
        .ThirdPartyLibs.watchOS,
    ],
    externalDependencies: [
        
    ],
    interfaceDependencies: [
        
    ],
    testingDependencies: [],
    demoDependencies: []
)
