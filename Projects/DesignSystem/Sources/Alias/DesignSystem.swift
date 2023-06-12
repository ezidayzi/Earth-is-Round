//
//  DesignSystem.swift
//  DesignSystem
//
//  Created by Junho Lee on 2023/06/12.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

#if os(iOS)
public typealias DesignSystemAsset = DesignSystemIosAsset
#elseif os(watchOS)
public typealias DesignSystemAsset = DesignSystemWatchosAsset
#endif
