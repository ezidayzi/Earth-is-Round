import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "MainFeature",
    targets: [.testing, .interface, .unitTest, .staticFramework, .demo],
    internalDependencies: [
        .Features.Setting.Interface,
        .Features.Splash.Interface
    ],
    externalDependencies: [
        
    ],
    interfaceDependencies: [
        .SPM.External.Alamofire
    ],
    testingDependencies: [],
    demoDependencies: []
)
