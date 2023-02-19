//
//  Dependencies.swift
//  Config
//
//  Created by sejin on 2022/10/02.
//

import ProjectDescription
import ProjectDescriptionHelpers

import DependencyPlugin

let spm = SwiftPackageManagerDependencies([
    .SPM.External.Alamofire,
    .SPM.External.Nimble,
    .SPM.External.Quick
])

let dependencies = Dependencies(
    carthage: [],
    swiftPackageManager: spm,
    platforms: [.iOS, .watchOS]
)
