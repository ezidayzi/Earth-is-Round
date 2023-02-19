import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.iOSApp(
    name: "EarthIsRound",
    targets: [.unitTest, .testing],
    internalDependencies: [],
    externalDependencies: [],
    testingDependencies: [],
    demoDependencies: []
)
