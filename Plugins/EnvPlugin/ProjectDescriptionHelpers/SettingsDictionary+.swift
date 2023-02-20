import ProjectDescription

public extension SettingsDictionary {    
    func setSwiftActiveComplationConditions(_ value: String) -> SettingsDictionary {
        merging(["SWIFT_ACTIVE_COMPILATION_CONDITIONS": SettingValue(stringLiteral: value)])
    }
    
    func setAlwaysSearchUserPath(_ value: String = "NO") -> SettingsDictionary {
        merging(["ALWAYS_SEARCH_USER_PATHS": SettingValue(stringLiteral: value)])
    }
    
    func setStripDebugSymbolsDuringCopy(_ value: String = "NO") -> SettingsDictionary {
        merging(["COPY_PHASE_STRIP": SettingValue(stringLiteral: value)])
    }
    
    func setDynamicLibraryInstallNameBase(_ value: String = "@rpath") -> SettingsDictionary {
        merging(["DYLIB_INSTALL_NAME_BASE": SettingValue(stringLiteral: value)])
    }
    
    func setSkipInstall(_ value: Bool = false) -> SettingsDictionary {
        merging(["SKIP_INSTALL": SettingValue(stringLiteral: value ? "YES" : "NO")])
    }
    
    func setCodeSignManual() -> SettingsDictionary {
        merging(["CODE_SIGN_STYLE": SettingValue(stringLiteral: "Manual")])
            .merging(["DEVELOPMENT_TEAM": SettingValue(stringLiteral: "FY8N9XTH66")])
            .merging(["CODE_SIGN_IDENTITY": SettingValue(stringLiteral: "iPhone Developer")])
    }
    
    func setProvisioningDevelopment() -> SettingsDictionary {
        merging(["PROVISIONING_PROFILE_SPECIFIER": SettingValue(stringLiteral: "")])
            .merging(["PROVISIONING_PROFILE": SettingValue(stringLiteral: "")])
    }
    
    func setProvisioningAppstore() -> SettingsDictionary {
        merging(["PROVISIONING_PROFILE_SPECIFIER": SettingValue(stringLiteral: "")])
            .merging(["CODE_SIGN_IDENTITY[sdk=iphoneos*]": SettingValue(stringLiteral: "")])
            .merging(["PROVISIONING_PROFILE": SettingValue(stringLiteral: "")])
    }
}

