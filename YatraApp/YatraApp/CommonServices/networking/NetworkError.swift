//
//  NetworkError.swift
//  ProgressCharter
//
//  Created by Sonam Gupta on 05/08/19.
//  Copyright © 2019 nmg. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case internalServerError
    case badRequest
    case unauthorized
    case forbidden
    case resourceNotFound(reason: String)
    case methodNotAllowed
    case unprocessableEntity
    case dataNotEncodable
    case invalidURL(url: String)
    case other(reason: Error)
    case noStatusCodeFound
    case sessionExpired(reason:String)
    case unknown
    case invalidResponseFormat
    case signupFailure(reason:String)
    case serverError(reason: String)


    
    /*
        What follows is the representations
        of invalid status codes that the server
        may return in its response
    */
    
    
    public static func fromStatusCode(code: Int) -> NetworkError? {
        switch (code) {
        case 200: return nil
        case 204: return nil
        case 401: return .badRequest
        //case 400: return .sessionExpired()
        case 403: return .forbidden
        case 404: return .resourceNotFound(reason: "Unknown")
        case 405: return .methodNotAllowed
        case 422: return .unprocessableEntity
        case 500: return .internalServerError
       // case 406: return .signupFailure
        
        default:
            return nil
        }
    }
    
    public var code: Int? {
        switch (self) {
        case .internalServerError: return 500
        case .badRequest: return 401
        case .unauthorized, .dataNotEncodable, .invalidURL(_),.serverError(_), .other(_), .noStatusCodeFound, .unknown, .invalidResponseFormat , .sessionExpired(_), .signupFailure(_): return nil
        case .forbidden: return 403
        case .resourceNotFound: return 404
        case .methodNotAllowed: return 405
        case .unprocessableEntity: return 422
       // case .signupFailure : return 406
       
        }
    }
}

extension NetworkError: LocalizedError {
    public var errorDescription: String?{
        switch self {
        case .internalServerError:
            return Strings.internalServerError.localizedValue
        case .badRequest:
            return Strings.badRequest.localizedValue
        case .unauthorized:
            return Strings.unauthorized.localizedValue
        case .forbidden:
            return Strings.forbidden.localizedValue
        case .resourceNotFound(let reason):
            return reason
        case .methodNotAllowed:
            return Strings.methodNotAllowed.localizedValue
        case .unprocessableEntity:
            return Strings.uprocessableEntity.localizedValue
        case .dataNotEncodable:
            return Strings.dataNotEncodable.localizedValue
        case .invalidURL(_):
            return Strings.invalidURL.localizedValue
        case .other(reason: let error):
            return error.localizedDescription
        case .noStatusCodeFound:
            return Strings.noStatusCodeFound.localizedValue
        case .sessionExpired(let reason):
            return reason
        case .unknown:
            return Strings.unknown.localizedValue
        case .invalidResponseFormat:
            return Strings.invalidResponseFormat.localizedValue
        case .signupFailure(let reason):
            return reason
        case .serverError( _):
            return Strings.internalServerError.localizedValue


        
        }
    }
}
