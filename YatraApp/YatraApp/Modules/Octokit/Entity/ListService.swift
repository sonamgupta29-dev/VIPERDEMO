//
//  ListService.swift
//  YatraApp
//
//  Created by NMG on 16/05/20.
//  Copyright © 2020 Yatra. All rights reserved.
//

import Foundation

protocol ListingSeviceDelegate: class {
    func service(_ service: ListingSevice, didStartFetchingListForPage page: Int)
    func service(_ service: ListingSevice, didFetchList list: [UserDetailModel], forPage page: Int)
    func service(_ service: ListingSevice, didFailToFetchListForPage page: Int, withError error: Error)
}

class ListingSevice {
    public weak var delegate: ListingSeviceDelegate?
    public var page: Int = 1
    private var isBusy: Bool = false
    private var totalPages: Int?
    
    init( delegate: ListingSeviceDelegate?) {
        self.delegate = delegate
    }
    
    public func callAPI() {
        if isBusy {
            return
        }
        if totalPages != nil && page >= totalPages! {
            return
        }
        isBusy = true
        delegate?.service(self, didStartFetchingListForPage: page)
        
        let request = GetListRequest(page: page)
        request.execute(retry: nil) { (result) in
            defer {
                self.isBusy = false
            }
            
            switch result {
            case .success(let response):
                self.totalPages = 4
                self.delegate?.service(self, didFetchList: response!, forPage: self.page)
            case .failure(let error):
                self.delegate?.service(self, didFailToFetchListForPage: self.page, withError: error)
            }
        }
        
    }
}
