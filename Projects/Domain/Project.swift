import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "Domain",
    platforms: [.iOS, .watchOS],
    targets: [.testing, .unitTest, .staticFramework],
    internalDependencies: [

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
