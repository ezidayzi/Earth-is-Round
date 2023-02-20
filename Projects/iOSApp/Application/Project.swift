import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin

let project = Project.iOSApp(
    name: "EarthIsRound",
    targets: [.unitTest, .testing],
    internalDependencies: [
        .Features.Main.Feature,
        .Features.Splash.Feature,
        .Features.Setting.Feature,
    ],
    externalDependencies: [
        
    ],
    testingDependencies: []
)
