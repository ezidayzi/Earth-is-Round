import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin

let project = Project.watchApp(
    name: "EarthIsRoundWatchApp",
    targets: [.unitTest, .testing],
    internalDependencies: [
        .Watch.Features.WatchMain.Feature
    ],
    externalDependencies: [
        
    ],
    testingDependencies: []
)
