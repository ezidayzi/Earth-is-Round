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
    static func performRequest<T: Decodable>(
        _ target: any Requestable
    ) async throws -> Result<T, ErrorCode>

    static func performRequest(
        _ target: any Requestable
    ) async throws -> Result<Bool, ErrorCode>
}

extension Serviceable {
    public static var session: URLSession {
        return URLSession.shared
    }
    
    public static func performRequest<T: Decodable>(
        _ target: any Requestable
    ) async throws -> Result<T, ErrorCode> {
        willSend(try target.asUrlRequest())

        let (data, response) = try await session.data(
            for: target.asUrlRequest()
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed
        }

        didRecieve(response: httpResponse, data: data)
        let decoder = JSONDecoder()
        let baseResponse = try decoder.decode(BaseResponse<T>.self, from: data)

        do {
            guard
                (200..<300).contains(httpResponse.statusCode),
                let response = baseResponse.response
            else {
                guard let errorCode = baseResponse.errorCode else {
                    throw APIError.decodingFailed(description: "ErrorCode decoding failed")
                }
                return .failure(errorCode)
            }
            return .success(response)
        } catch {
            throw APIError.decodingFailed(description: error.localizedDescription)
        }
    }

    public static func performRequest(
        _ target: any Requestable
    ) async throws -> Result<Bool, ErrorCode> {
        willSend(try target.asUrlRequest())

        let (data, response) = try await session.data(
            for: target.asUrlRequest()
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed
        }

        didRecieve(response: httpResponse, data: data)

        let decoder = JSONDecoder()
        let baseResponse = try decoder.decode(BaseResponse<Bool>.self, from: data)

        do {
            guard
                (200..<300).contains(httpResponse.statusCode)
            else {
                guard let errorCode = baseResponse.errorCode else {
                    throw APIError.decodingFailed(description: "ErrorCode decoding failed")
                }
                return .failure(errorCode)
            }
            return .success(true)
        } catch {
            throw APIError.decodingFailed(description: error.localizedDescription)
        }
    }
}

extension Serviceable {
    private static func willSend(_ request: URLRequest) {
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = URLComponents(string: urlAsString)
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        var output = """
         \(urlAsString) \n\n
         \(method) \(path)?\(query) HTTP/1.1 \n
         HOST: \(host)\n
         """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            output += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            output += "\n \(String(data: body, encoding: .utf8) ?? "")"
        }
        print(output)
    }

    private static func didRecieve(response: HTTPURLResponse?, data: Data?) {
        print("\n - - - - - - - - - - INCOMMING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        var output = ""
        if let urlString = urlString {
            output += "\(urlString)"
            output += "\n\n"
        }
        if let statusCode =  response?.statusCode {
            output += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host {
            output += "Host: \(host)\n"
        }
        for (key, value) in response?.allHeaderFields ?? [:] {
            output += "\(key): \(value)\n"
        }
        if let body = data {
            output += "\n\(String(data: body, encoding: .utf8) ?? "")\n"
        }
        print(output)
    }
}
