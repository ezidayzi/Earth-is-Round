//
//  BaseService.swift
//  APIClient
//
//  Created by Junho Lee on 2023/04/18.
//  Copyright © 2023 com.earthIsRound. All rights reserved.
//

import Foundation

import Shared_ios

public protocol Serviceable {
    static func performRequest<T: Codable>(
        _ target: any Requestable
    ) async throws -> T
}

extension Serviceable {
    public static var session: URLSession {
        return URLSession.shared
    }
    
    public static func performRequest<T: Codable>(
        _ target: any Requestable
    ) async throws -> T {
        let (data, response) = try await session.data(
            for: target.asUrlRequest()
        )
        
        debugPrint("Request: ", try target.asUrlRequest())
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed
        }
        
        guard httpResponse.statusCode == 200 else {
            throw APIError.responseError(
                description: "\(httpResponse.statusCode)"
            )
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed(description: error.localizedDescription)
        }
    }
}

