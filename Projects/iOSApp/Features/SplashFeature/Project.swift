import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "SplashFeature",
    targets: [.testing, .interface, .unitTest, .staticFramework, .demo],
    internalDependencies: [
        .Features.Setting.Interface,
        .Features.Main.Interface
    ],
    externalDependencies: [
        
    ],
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ],
    testingDependencies: [],
    demoDependencies: []
)
