//
//  QiitaUser.swift
//  PMApiClient
//
//  Created by Taku Inoue on 2016/05/16.
//  Copyright © 2016年 Yumemi Inc. All rights reserved.
//

import ObjectMapper

struct QiitaUser: Mappable {
    var id : String = ""
    var name : String = ""
    var organization : String = ""
    var profileImageUrl : String = ""
    var description : String = ""
    var followeesCount : Int = 0
    var followersCount : Int = 0

    init?(_ map: Map) { }

    mutating func mapping(map: Map) {
        id              <- map["id"]
        name            <- map["name"]
        organization    <- map["organization"]
        profileImageUrl <- map["profile_image_url"]
        description     <- map["description"]
        followeesCount  <- map["followees_count"]
        followersCount  <- map["followers_count"]
    }
}
