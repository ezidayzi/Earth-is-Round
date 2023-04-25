import ProjectDescription

public enum Environment {
    public static let workspaceName = "EarthIsRound"
    public static let bundlePrefix = "com.earthIsRound"
}

public extension Project {
    public enum Environment {
        public static let workspaceName = "EarthIsRound"
        public static let iphoneDeploymentTarget = DeploymentTarget.iOS(targetVersion: "16.0", devices: [.iphone])
        public static let watchDeploymentTarget = DeploymentTarget.watchOS(targetVersion: "8.0")
        public static let bundlePrefix = "com.earthIsRound"
    }
}
