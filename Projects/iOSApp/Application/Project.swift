import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin

let project = Project.iOSApp(
    name: "EarthIsRound",
    targets: [.unitTest, .testing],
    internalDependencies: [
        .Features.RootFeature
    ],
    externalDependencies: [
        
    ],
    testingDependencies: []
)
