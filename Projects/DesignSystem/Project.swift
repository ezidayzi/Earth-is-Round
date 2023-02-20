import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "DesignSystem",
    platforms: [.iOS, .watchOS],
    targets: [.testing, .unitTest, .dynamicFramework, .demo],
    internalDependencies: [
        .Shared.iOS,
        .Shared.watchOS
    ],
    externalDependencies: [
        .SPM.External.Lottie
    ],
    testingDependencies: [],
    demoDependencies: []
)
