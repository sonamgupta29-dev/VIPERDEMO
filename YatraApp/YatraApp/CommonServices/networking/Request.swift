//
//  Request.swift
//  ProgressCharter
//
//  Created by Sonam Gupta on 05/08/19.
//  Copyright © 2019 nmg. All rights reserved.
//

import Foundation

class Request: RequestProtocol {
    var headers: [String : String]?
    
    var endPoint: String
    
    var method: RequestMethod
    
    var fields: [String : String]?
    
    var urlParams: [String : String]?
    
    var body: Data?
    
    var cachePolicy: URLRequest.CachePolicy?
    
    var timeout: TimeInterval?
    
    public init(method: RequestMethod = .get,
                endPoint: String = "",
                params: [String:String]? = nil,
                fields: [String:String]? = nil,
                body: Data? = nil ) {
        self.method = method
        self.endPoint = endPoint
        self.urlParams = params
        self.fields = fields
        self.body = body
    }
}
