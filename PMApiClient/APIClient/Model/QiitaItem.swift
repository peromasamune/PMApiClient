//
//  QiitaItems.swift
//  PMApiClient
//
//  Created by Taku Inoue on 2016/05/16.
//  Copyright © 2016年 Yumemi Inc. All rights reserved.
//

import ObjectMapper

struct QiitaItem : Mappable {
    var id  : String = ""
    var title : String = ""
    var url : String = ""
    var user : QiitaUser?
    var createdAt : String = ""
    var updatedAt : String = ""

    init?(_ map: Map) { }

    mutating func mapping(map: Map) {
        id          <- map["id"]
        title       <- map["title"]
        url         <- map["url"]
        user        <- map["user"]
        createdAt   <- map["created_at"]
        updatedAt   <- map["updated_at"]
    }
}
