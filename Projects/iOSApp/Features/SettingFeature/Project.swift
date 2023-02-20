import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "SettingFeature",
    targets: [.testing, .interface, .unitTest, .staticFramework, .demo],
    internalDependencies: [
        .Features.Main.Interface,
        .Features.Splash.Interface
    ],
    externalDependencies: [
        
    ],
    interfaceDependencies: [
        .SPM.External.Alamofire,
        .Domain.iOS
    ],
    testingDependencies: [],
    demoDependencies: []
)
