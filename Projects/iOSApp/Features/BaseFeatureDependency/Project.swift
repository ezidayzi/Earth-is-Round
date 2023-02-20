import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "BaseFeatureDependency",
    targets: [.dynamicFramework],
    internalDependencies: [
        .Core.iOS,
        .Domain.iOS
    ],
    externalDependencies: [
        
    ],
    interfaceDependencies: [

    ],
    testingDependencies: [],
    demoDependencies: []
)
