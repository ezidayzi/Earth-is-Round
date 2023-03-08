import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "ThirdPartyLibs",
    platforms: [.iOS, .watchOS],
    targets: [.dynamicFramework],
    externalDependencies: [
        .SPM.External.Alamofire,
        .SPM.External.TCA,
        .SPM.External.TCACoordinator
    ]
)
