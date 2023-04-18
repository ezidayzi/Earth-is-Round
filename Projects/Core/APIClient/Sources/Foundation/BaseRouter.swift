//
//  BaseRouter.swift
//  APIClient
//
//  Created by Junho Lee on 2023/04/18.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import Foundation

#if os(iOS)
import Shared_ios
#elseif os(watchOS)
import Shared_watchOS
#endif

protocol BaseRouter: Requestable {
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var query: [String: String?] { get }
    var version: String { get }
    var method: HttpMethod { get }
}

extension BaseRouter {
    var baseURL: String {
        return Config.Network.baseURL
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
    
    var version: String {
        return ""
    }
}

extension BaseRouter {
    func asUrlRequest() throws -> URLRequest {
        // path
        var components = URLComponents(string: baseURL)
        components?.path = version + path
        
        // queryParams
        if !query.isEmpty {
            components?.queryItems = query.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        // urlRequest
        guard let url = components?.url else {
            throw APIError.invalidRequestError
        }
        var urlRequest = URLRequest(url: url)
        
        // httpMethod
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        // httpBody
        if method == .POST {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params)
        }
        
        return urlRequest
    }
}

