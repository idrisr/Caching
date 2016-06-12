//
//  NetworkClient.swift
//  Caching
//
//  Created by id on 6/10/16.
//  Copyright © 2016 id. All rights reserved.
//

import Foundation

typealias NetworkResult = (AnyObject?, ErrorType?) -> Void

class NetworkClient: NSObject {
    static let sharedInstance = NetworkClient()

    func getURLResponse(URL: NSURL, completion: NetworkResult) -> NSURLSessionDataTask {
        let request = NSURLRequest(URL: URL)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            if error == nil {
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    completion(response, nil)
                }
            } else {
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    completion(nil, error)
                }
            }
        }
        return task
    }
}

struct NasaURL {
    let date: String!

    init(date: String) {
        self.date = date
    }

    var url: NSURL {
        get {
            // put your own api key here
            let api_key = "ZBrv2wKXCEGK34TQx21taIwI8nfxAQrdLWLpJ8to"

            let host = "api.nasa.gov"
            let scheme = "https"
            let path = "planetary/apod"
            let urlComponents = NSURLComponents()
            urlComponents.path = "/" + path
            urlComponents.host = host
            urlComponents.scheme = scheme
            urlComponents.queryItems = [NSURLQueryItem(name: "api_key", value: api_key),
                NSURLQueryItem(name: "date", value: self.date)]
            return urlComponents.URL!
        }
    }
}