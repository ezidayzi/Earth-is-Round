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
        .SPM.External.Alamofire,
        .Domain.watchOS
    ],
    testingDependencies: [],
    demoDependencies: []
)
