//
//  RequestProtocol.swift
//  ProgressCharter
//
//  Created by Sonam Gupta on 05/08/19.
//  Copyright © 2019 nmg. All rights reserved.
//

import Foundation

protocol RequestProtocol {
    var endPoint: String {get set}
    var method: RequestMethod {get set}
    var fields: [String:String]? {get set}
    var urlParams: [String:String]? { get set}
    var body: Data? {get set}
    var headers: [String:String]? { get set}
    var cachePolicy: URLRequest.CachePolicy? { get set}
    var timeout: TimeInterval? {get set}
    func headers(in service: ServiceProtocol) -> [String:String]
    func url(in service: ServiceProtocol) throws -> URL
    func urlRequest(in service: ServiceProtocol) throws -> URLRequest
}

extension RequestProtocol {
    func headers(in service: ServiceProtocol) -> [String:String] {
        var params = service.headers
        let headers = self.headers ?? [:]
        headers.forEach( { (key,value) in
            params[key] = value
        })
        
        return params
    }
    
    func url(in service: ServiceProtocol)  throws -> URL {
        let baseURL = service.configuration.url.appendingPathComponent(endPoint)
        var finalString = baseURL.absoluteString
        
        if let urlParams = self.urlParams {
            urlParams.forEach {
                finalString = finalString.replacingOccurrences(of: "{\($0.key)}", with: String(describing: $0.value))
            }
        }
        
        if fields != nil {
            finalString = try finalString.stringByAdding(urlEncodedFields: fields!)
        }
        
        guard let url = URL(string: finalString) else {
            throw NetworkError.invalidURL(url: finalString)
        }
        
        return url
    }
    
    func urlRequest(in service: ServiceProtocol) throws -> URLRequest {
        let requestURL = try url(in: service)
        let cachePolicy = self.cachePolicy ?? service.configuration.cachePolicy
        let timeout = self.timeout ?? service.configuration.timeout
        let headers = self.headers(in: service)
        
        var request = URLRequest(url: requestURL, cachePolicy: cachePolicy, timeoutInterval: timeout)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        if let requestBody = body {
            request.httpBody = requestBody
        }
        return request
    }
}

