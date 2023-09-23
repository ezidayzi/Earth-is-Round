import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "LocalStorageClient",
    platforms: [.iOS, .watchOS],
    targets: [.unitTest, .dynamicFramework],
    internalDependencies: [
        .Shared.iOS,
        .Shared.watchOS,
    ],
    externalDependencies: [
        .SPM.External.RealmSwift
    ],
    interfaceDependencies: [

    ],
    testingDependencies: [],
    demoDependencies: []
)

