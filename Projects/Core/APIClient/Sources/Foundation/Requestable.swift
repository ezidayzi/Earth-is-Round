//
//  Requestable.swift
//  APIClient
//
//  Created by Junho Lee on 2023/04/18.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import Foundation

public protocol Requestable {
    func asUrlRequest() throws -> URLRequest
}
