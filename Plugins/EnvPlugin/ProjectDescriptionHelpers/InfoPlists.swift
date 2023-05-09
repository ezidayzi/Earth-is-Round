import ProjectDescription

public extension Project {
    public static let iosAppInfoPlist: [String: InfoPlist.Value] = [
        "CFBundleDevelopmentRegion": "ko",
        "CFBundleIdentifier": "\(Environment.bundlePrefix).release",
        "CFBundleDisplayName": "지구는 둥그니까",
        "UIMainStoryboardFile": "",
        "UISupportedInterfaceOrientations": [
            "UIInterfaceOrientationPortrait",
        ],
        "UILaunchStoryboardName": "LaunchScreen",
        "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
        "ITSAppUsesNonExemptEncryption": false,
        "UIUserInterfaceStyle": "Light",
        "NSMotionUsageDescription": "걸음수 데이터 측정을 위해 데이터 접근 권한이 필요합니다.",
        "NSHealthShareUsageDescription": "걸음수 데이터 측정을 위해 건강 정보 접근 권한이 필요합니다.",
        "NSHealthUpdateUsageDescription": "걸음수 데이터 측정을 위해 건강 정보 접근 권한이 필요합니다.",
    ]
    
    public static let watchAppSettings: SettingsDictionary = [
        "GENERATE_INFOPLIST_FILE": true,
        "CURRENT_PROJECT_VERSION": "1.0.0",
        "MARKETING_VERSION": "1.0.0",
        "INFOPLIST_KEY_UISupportedInterfaceOrientations": [
            "UIInterfaceOrientationPortrait",
            "UIInterfaceOrientationPortraitUpsideDown",
        ],
        "INFOPLIST_KEY_WKCompanionAppBundleIdentifier": "\(Environment.bundlePrefix).release",
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
