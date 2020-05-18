//
//  GetListRequest.swift
//  YatraApp
//
//  Created by NMG on 16/05/20.
//  Copyright © 2020 Yatra. All rights reserved.
//

import Foundation
class GetListRequest: DataOperation<UserDetailModel> {
    let page: Int
    private let endPoint: String = ApiConfig.repo
    init(page: Int){
           self.page = page
           super.init()
        self.request = Request(method: .get
            , endPoint: endPoint, params: nil, fields: ["page" : "\(page)","per_page" : "10"], body: nil)
    }
}
