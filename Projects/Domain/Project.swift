import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "Domain",
    platforms: [.iOS, .watchOS],
    targets: [.testing, .unitTest, .dynamicFramework],
    internalDependencies: [
        .Shared.iOS,
        .Shared.watchOS,
    ],
    externalDependencies: [
        
    ],
    interfaceDependencies: [

    ],
    testingDependencies: [
    
    ],
    demoDependencies: [
        
    ]
)
