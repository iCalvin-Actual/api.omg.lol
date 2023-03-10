//
//  APIRequestConstructor.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

class APIRequestConstructor {
    
    static let encoder: JSONEncoder = {
        var encoder = JSONEncoder()
        
        return encoder
    }()
    
    static func multipartUrlRequest<O, I>(from apiRequest: APIRequest<O, I>) -> URLRequest {
        var request = standardURLRequest(from: apiRequest)
        
        if let bodyParameters = apiRequest.body, O.Type.self != None.Type.self {
            do {
                request.httpBody = try createMultipartData(for: bodyParameters)
            } catch {
                // Do nothing, body won't be included and will return error
            }
        }
        
        return request
    }
    
    static func urlRequest<O, I>(from apiRequest: APIRequest<O, I>) -> URLRequest {
        var request = standardURLRequest(from: apiRequest)
        
        if let bodyParameters = apiRequest.body, O.Type.self != None.Type.self {
            do {
                request.httpBody = try createBodyData(for: bodyParameters)
            } catch {
                // Do nothing, body won't be included and will return error
            }
        }
        
        return request
    }
    
    static private func standardURLRequest<O, I>(from apiRequest: APIRequest<O, I>) -> URLRequest {
        var request = URLRequest(url: apiRequest.path.url)

        request.httpMethod = apiRequest.method.rawValue
        
        if let key = apiRequest.authorization {
            request.addValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    private static func createBodyData<T: Encodable>(for body: T) throws -> Data {
        try Self.encoder.encode(body)
    }
    
    private static func createMultipartData<T: Encodable>(for body: T) throws -> Data {
        let encoded = try createBodyData(for: body)
        var multipartData = Data()
        
        let lineBreak = "\r\n"
        let boundary: String = "Boundary-\("562F49C8-26CD-4D87-9C8F-DEA380DE4BF007")"
        let file = "multipartData"
        let boundaryPrefix = "--\(boundary)\r\n"
        multipartData.append(Data(boundaryPrefix.utf8))
        multipartData.append(Data("Content-Disposition: form-data; name=\"\(file)\"\r\n".utf8))
        multipartData.append(Data("Content-Type: \("application/json;charset=utf-8")\r\n\r\n".utf8))
        multipartData.append(encoded)
        multipartData.append(Data("\r\n".utf8))
        multipartData.append(Data("--\(boundary)--\(lineBreak)".utf8))
        
        return multipartData
    }
}

