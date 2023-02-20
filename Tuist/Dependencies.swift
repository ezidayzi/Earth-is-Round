//
//  Dependencies.swift
//  Config
//
//  Created by sejin on 2022/10/02.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin
import ConfigPlugin

let spm = SwiftPackageManagerDependencies([
    .SPM.External.Alamofire,
    .SPM.External.TCA,
    .SPM.External.Nimble,
    .SPM.External.Quick
], baseSettings: Settings.settings(
    configurations: XCConfig.framework
))

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: spm,
    platforms: [.iOS, .watchOS]
)
