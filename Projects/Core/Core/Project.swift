import ProjectDescriptionHelpers
import ProjectDescription
import DependencyPlugin
import EnvPlugin

let project = Project.framework(
    name: "Core",
    platforms: [.iOS, .watchOS],
    targets: [.unitTest, .dynamicFramework, .demo, .testing],
    internalDependencies: [
        .Core.PedometerClient.iOS,
        .Core.PedometerClient.watchOS,
        .Core.APIClient.iOS,
        .Core.APIClient.watchOS,
        .Core.HealthClient.iOS,
        .Core.HealthClient.watchOS,
        .Core.LocationClient.iOS,
        .Core.LocationClient.watchOS,
        .Core.LocalStorageClient.iOS,
        .Core.LocalStorageClient.watchOS,
        .Core.PushNotificationClient.iOS,
        .Core.PushNotificationClient.watchOS
    ],
    externalDependencies: [
        
    ],
    interfaceDependencies: [
        
    ],
    testingDependencies: [],
    demoDependencies: []
)
