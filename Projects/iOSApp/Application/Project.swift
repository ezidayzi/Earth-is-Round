import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin

let project = Project.iOSApp(
    name: "EarthIsRound",
    targets: [.unitTest, .testing],
    entitlements: "EarthIsRound.entitlements",
    internalDependencies: [
        .Features.RootFeature
    ],
    externalDependencies: [
        
    ],
    testingDependencies: []
)
