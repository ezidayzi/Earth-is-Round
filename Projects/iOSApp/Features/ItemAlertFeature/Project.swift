import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "ItemAlertFeature",
    targets: [.testing, .unitTest, .staticFramework, .demo],
    internalDependencies: [
        .Features.BaseFeatureDependency
    ],
    externalDependencies: [
        
    ],
    interfaceDependencies: [
        
    ],
    testingDependencies: [],
    demoDependencies: []
)
