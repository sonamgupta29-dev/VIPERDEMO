//
//  StringExtension.swift
//  DemoBasic
//
//  Created by Sonam Gupta on 12/11/2019.
//  Copyright © 2019 Sonam Gupta. All rights reserved.
//

import Foundation
extension String {
    public var localized: String {
        
        return NSLocalizedString(self, comment: "")
        
    }
    
    
    
    public var isBackSpace: Bool {
        
        if let char = cString(using: String.Encoding.utf8) {
            
            let isBackSpace = strcmp(char, "\\b")
            
            if (isBackSpace == -92) {
                
                return true
                
            }
            
        }
        
        return false
        
    }
    
    
    
    public func stringByAdding(urlEncodedFields fields: Dictionary<String,Any?>) throws -> String {
        
        return try fields.urlEncodedString(base: self)
        
    }
    
   
    
}
