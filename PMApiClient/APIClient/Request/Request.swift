//
//  Request.swift
//  PMApiClient
//
//  Created by Taku Inoue on 2016/05/16.
//  Copyright © 2016年 Yumemi Inc. All rights reserved.
//

import ObjectMapper

public enum Method: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

protocol Request {
    typealias Response

    var baseURL : NSURL { get }
    var method : Method { get }
    var path : String { get }
    var parameters : [String : AnyObject] { get }
    var HTTPHeaderFields : [String : String] { get }

    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response?
    func errorFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> ErrorType?
}

extension Request {
    var baseURL : NSURL {
        return NSURL(string: "http://qiita.com/api/v2")!
    }

    var HTTPHeaderFields : [String : String] {
        return [:]
    }

    func errorFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> ErrorType? {
        print(self.decode(object.description))
        return nil
    }

    func decode(string : String) -> String {
        let decStr = NSString(CString: string.cStringUsingEncoding(NSASCIIStringEncoding)!, encoding: NSNonLossyASCIIStringEncoding)
        return String(decStr)
    }
}

extension Request where Response:Mappable {
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        print(self.decode(object.description))

        guard let model = Mapper<Response>().map(object) else{
            return nil
        }
        return model
    }
}