import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin

let project = Project.watchApp(
    name: "EarthIsRoundWatchApp",
    targets: [.unitTest, .testing],
    internalDependencies: [
        
    ],
    externalDependencies: [
        .SPM.External.Alamofire
    ],
    testingDependencies: []
)
