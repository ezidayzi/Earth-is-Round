import ProjectDescription

public extension Project {
    public static let iosAppInfoPlist: [String: InfoPlist.Value] = [
        "CFBundleShortVersionString": "1.0.0",
        "CFBundleDevelopmentRegion": "ko",
        "CFBundleVersion": "1",
        "CFBundleIdentifier": "com.earthIsRound.release",
        "CFBundleDisplayName": "지구는 둥그니까",
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen",
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ],
        "App Transport Security Settings": ["Allow Arbitrary Loads": true],
        "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
        "ITSAppUsesNonExemptEncryption": false,
        "UIUserInterfaceStyle": "Light",
    ]
    
    public static let watchAppInfoPlist: [String: InfoPlist.Value] = [
        :
    ]
    
    public static let demoInfoPlist: [String: InfoPlist.Value] = [
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen",
        "LSSupportsOpeningDocumentsInPlace": true,
        "UIFileSharingEnabled": true,
    ]
}
