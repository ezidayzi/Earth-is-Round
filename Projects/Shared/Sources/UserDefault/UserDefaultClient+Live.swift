//
//  UserDefaultClient+Live.swift
//  Shared_ios
//
//  Created by 김윤서 on 2023/08/21.
//  Copyright © 2023 EarthIsRound. All rights reserved.
//

import Foundation
import Dependencies

extension UserDefaultsClient {
  public static let liveValue: Self = {
    let defaults = { UserDefaults(suiteName: "group.com.earthIsRound")! }
    return Self(
      boolForKey: { defaults().bool(forKey: $0) },
      dataForKey: { defaults().data(forKey: $0) },
      doubleForKey: { defaults().double(forKey: $0) },
      integerForKey: { defaults().integer(forKey: $0) },
      stringForKey: { defaults().string(forKey: $0) ?? "" },
      remove: { defaults().removeObject(forKey: $0) },
      setBool: { defaults().set($0, forKey: $1) },
      setData: { defaults().set($0, forKey: $1) },
      setDouble: { defaults().set($0, forKey: $1) },
      setInteger: { defaults().set($0, forKey: $1) },
      setString: { defaults().set($0, forKey: $1) }
    )
  }()
}
