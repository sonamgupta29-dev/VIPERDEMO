//
//  Response.swift
//  ProgressCharter
//
//  Created by Sonam Gupta on 05/08/19.
//  Copyright © 2019 nmg. All rights reserved.
//

import Foundation

public enum ResponseType {
    case success(_: Int)
    case error(_: NetworkError)
    case noResponse
    
    private static let successCodes: Range<Int> = 200..<299
    
    public static func fromResponse(_ response: HTTPURLResponse?) -> ResponseType {
        guard let r = response else {
            return .noResponse
        }
        
    /*
        1. check the http status code of response
        2. if other than success codes, look for the suitable error and save it
    */
        
        if (ResponseType.successCodes.contains(r.statusCode) || r.statusCode == 404) {
            return  .success(r.statusCode)
        }else{
            if let error = NetworkError.fromStatusCode(code: r.statusCode) {
                return .error(error)
            }else{
                return .error(.unknown)
            }
        }
    }
    
    private var code: Int? {
        switch (self) {
        case .success(let code) : return code
        case .error( let e) : return e.code
        case .noResponse: return nil
        }
    }
}


public class Response: ResponseProtocol {
    var request: RequestProtocol
    
    public var type: ResponseType
    
    public var httpResponse: HTTPURLResponse
    
    public var httpStatusCode: Int
    
    public var data: Data?
    
    public var jsonObject: Any?
    public var message: String?

    public func toJSON() throws -> [String : Any] {
        let jsonObject = try JSONSerialization.jsonObject(with: data ?? Data(), options: [])
        return jsonObject as? [String:Any] ?? [:]
    }
    
    public func toString() -> String? {
        return String(data: self.data ?? Data(), encoding: .utf8)
    }
    
    
    init(networkResponse: HTTPURLResponse, request: RequestProtocol, data: Data?) {
        self.httpResponse = networkResponse
        self.httpStatusCode = networkResponse.statusCode
        self.request = request
        self.data = data
        
        let initialType = ResponseType.fromResponse(networkResponse)
        
        switch initialType {
        case .error(_), .noResponse :
            //the server itself returned an error
            if self.httpStatusCode == 401 {
                self.type = .error(.sessionExpired(reason: ""))
            }else {
                self.type = initialType
                
            }
        case .success(_):
            //the server was able to return some response
            //check the response status code and determine whether its an error state
            do {
                guard
                    let jsonObject = try JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [[String:Any]]
//                    let status = jsonObject["statusCode"] as? Int
//                    let message = jsonObject["message"] as? String
                else{
                    self.type = .error(.invalidResponseFormat)
                    return
                }
                self.jsonObject = jsonObject
                                   self.message = ""
                self.type = ResponseType.success(1)
                //check whether the server return 101 status code. 101 status code implies a successful operation
//                if (status == 200) {
//                    self.jsonObject = jsonObject["data"]
//                    self.message = jsonObject["status"] as? String
//                    self.type = .success(status)
//                }else if (status == 400) {
//                    let message = jsonObject["status"] as? String ?? "Message key is not present in response."
//                     self.type = .error(.sessionExpired(reason: message))
//                }else if (status == 406) {
//                    let message = jsonObject["status"] as? String ?? "Message key is not present in response."
//                    self.type = .error(.signupFailure(reason: message))}
//
//               else if (status == 404) {
//                    let message = jsonObject["status"] as? String ?? "Message key is not present in response."
//                    self.type = .error(.resourceNotFound(reason: message))}
//                 else{
//                     let message = jsonObject["status"] as? String ?? "Message key is not present in response."
//                     self.type = .error(.serverError(reason: message))
//
//                    }
                }catch{
                self.type = .error(.invalidResponseFormat)
            }
        }
        
    }
    
    
    
    
}
