import ProjectDescription

public extension Project {
    public static let iosAppInfoPlist: [String: InfoPlist.Value] = [
        "CFBundleDevelopmentRegion": "ko",
        "CFBundleIdentifier": "com.earthIsRound.release",
        "CFBundleDisplayName": "지구는 둥그니까",
        "UIMainStoryboardFile": "",
        "UISupportedInterfaceOrientations": [
            "UIInterfaceOrientationPortrait",
        ],
        "UILaunchStoryboardName": "LaunchScreen",
        "App Transport Security Settings": ["Allow Arbitrary Loads": true],
        "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
        "ITSAppUsesNonExemptEncryption": false,
        "UIUserInterfaceStyle": "Light",
    ]
    
    public static let watchAppSettings: SettingsDictionary = [
        "GENERATE_INFOPLIST_FILE": true,
        "CURRENT_PROJECT_VERSION": "1.0.0",
        "MARKETING_VERSION": "1.0.0",
        "INFOPLIST_KEY_UISupportedInterfaceOrientations": [
            "UIInterfaceOrientationPortrait",
            "UIInterfaceOrientationPortraitUpsideDown",
        ],
        "INFOPLIST_KEY_WKCompanionAppBundleIdentifier": "com.earthIsRound.release",
        "INFOPLIST_KEY_WKRunsIndependentlyOfCompanionApp": true,
        "INFOPLIST_KEY_CFBundleDisplayName": "지구는 둥그니까",
    ]
    
    public static let demoInfoPlist: [String: InfoPlist.Value] = [
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen",
        "LSSupportsOpeningDocumentsInPlace": true,
        "UIFileSharingEnabled": true,
    ]
}
