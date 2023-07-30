import ProjectDescription

public enum Const {
    public static let workspaceName = "EarthIsRound"
    public static let bundlePrefix = "com.earthIsRound"
    public static let iphoneDeploymentTarget = DeploymentTarget.iOS(targetVersion: "16.0", devices: [.iphone])
    public static let watchDeploymentTarget = DeploymentTarget.watchOS(targetVersion: "8.0")
}

public extension Project {
    public enum Const {
        public static let workspaceName = "EarthIsRound"
        public static let iphoneDeploymentTarget = DeploymentTarget.iOS(targetVersion: "16.0", devices: [.iphone])
        public static let watchDeploymentTarget = DeploymentTarget.watchOS(targetVersion: "8.0")
        public static let bundlePrefix = "com.earthIsRound"
        public static let widgetBundleId = bundlePrefix + ".release.widget"
    }
}
