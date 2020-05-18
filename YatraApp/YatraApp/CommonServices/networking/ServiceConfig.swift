//
//  ServiceConfig.swift
//  ProgressCharter
//
//  Created by Sonam Gupta on 05/08/19.
//  Copyright © 2019 nmg. All rights reserved.
//

import Foundation


public final class ServiceConfig: Equatable{
    private(set) var name: String
    private(set)var url: URL
    private(set) var headers: [String:String] = [:]
    public var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    public var timeout: TimeInterval = 15.0
    
    public init?(name: String?, base urlString: String) {
        guard let url = URL(string: urlString) else { return nil }
        self.url = url
        self.name = name ?? url.host ?? ""
    }
    
    public static func appConfig() -> ServiceConfig?{
        return ServiceConfig()
    }
    
    public convenience init?(){
        guard
            let config = Bundle.main.object(forInfoDictionaryKey: "Endpoint") as? [String:Any],
            let baseURL = config["url"] as? String,
            var commonHeaders = config["headers"] as? [String:String]
        else {
            return nil
        }
        
//        if let token = Disk.userModel?.token {
            commonHeaders["Authorization"] = ""
//        }
        
        print(commonHeaders)
        self.init(name: nil, base: baseURL)
        headers = commonHeaders
        
    }
    
    public var description: String {
        return "\(name): \(url.absoluteString)"
    }
    
    
    public static func == (lhs: ServiceConfig, rhs: ServiceConfig) -> Bool {
        return lhs.url.absoluteString.lowercased() == rhs.url.absoluteString.lowercased()
    }
    
}
