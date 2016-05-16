//
//  APIClient.swift
//  PMApiClient
//
//  Created by Taku Inoue on 2016/05/16.
//  Copyright © 2016年 Yumemi Inc. All rights reserved.
//

import Alamofire
import SwiftTask

public enum APIError : ErrorType {
    case ConnectionError(NSError)
    case InvalidResponse(AnyObject?)
    case ParseError(AnyObject?)
}

struct APIClient {
    static func request<T : Request>(request : T) -> Task<Float, T.Response, APIError> {

        let endPoint    = request.baseURL.absoluteString+request.path
        let params      = request.parameters
        let headers     = request.HTTPHeaderFields
        let method      = Alamofire.Method(rawValue: request.method.rawValue) ?? .GET
        let encoding    = (method == .GET) ? ParameterEncoding.URL : ParameterEncoding.JSON

        let task = Task<Float, T.Response, APIError> { progress, fulfill, reject, configure in
            let req = Alamofire.request(method, endPoint, parameters: params, encoding: encoding, headers: headers)
                .validate(statusCode: 200..<300)
                .progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                    if totalBytesExpectedToWrite != 0 {
                        let prog = Float(totalBytesWritten / totalBytesExpectedToWrite)
                        progress(prog)
                    }
                }
                .responseJSON(completionHandler: { response in
                    if let error = response.result.error {
                        reject(.ConnectionError(error))
                        return
                    }

                    if let object = response.result.value, URLResponse = response.response {
                        guard let model = request.responseFromObject(object, URLResponse: URLResponse) else {
                            reject(.ParseError(object))
                            return
                        }
                        fulfill(model)
                    }else {
                        reject(.InvalidResponse(nil))
                    }
                })

            print(req)
            print(req.debugDescription)
        }
        return task
    }
}
