//
//  ItemsRequest.swift
//  PMApiClient
//
//  Created by Taku Inoue on 2016/05/16.
//  Copyright © 2016年 Yumemi Inc. All rights reserved.
//

import UIKit
import ObjectMapper

struct ItemsRequest : Request {
    //MARK: Params
    var page : Int = 1
    var perPage : Int = 10

    //MARK: Protocol
    typealias ResponseComponent = QiitaItem
    typealias Response = [ResponseComponent]

    var method : Method {
        return .GET
    }

    var path : String {
        return "/items"
    }

    var parameters : [String : AnyObject] {
        return [
            "page"      : self.page,
            "per_page"  : self.perPage
        ]
    }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        guard let model = Mapper<ResponseComponent>().mapArray(object) else{
            return nil
        }
        return model
    }
}
