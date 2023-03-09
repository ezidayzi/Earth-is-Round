import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "RootFeature",
    targets: [.testing, .unitTest, .staticFramework, .demo],
    internalDependencies: [
        .Features.Splash.Feature,
        .Features.Auth.Feature,
        .Features.Main.Feature,
        .Features.Setting.Feature,
        .Features.Archive.Feature,
        .Features.SnowmanAlert.Feature,
        .Features.ItemAlert.Feature
    ],
    externalDependencies: [
        
    ],
    testingDependencies: [],
    demoDependencies: []
)
