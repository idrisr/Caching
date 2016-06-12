//
//  NasaURLCache.swift
//  Caching
//
//  Created by id on 6/12/16.
//  Copyright © 2016 id. All rights reserved.
//

import UIKit

class NasaURLCache: NSURLCache {
    override func storeCachedResponse(cachedResponse: NSCachedURLResponse, forRequest request: NSURLRequest) {

        guard let response = cachedResponse.response as? NSHTTPURLResponse else {
            NSLog("couldn't convert to http response")
            return
        }

        guard response.statusCode == 200 else {
            if response.statusCode == 429 {
                NSLog("Over API Hourly Limit")
            } else {
                NSLog("\(response.statusCode)")
            };
            return
        }

        var headers = response.allHeaderFields
        headers.removeValueForKey("Cache-Control")
        headers["Cache-Control"] = "max-age=\(7 * 24 * 60 * 60)"

        if let
            headers = headers as? [String: String],
            newHTTPURLResponse = NSHTTPURLResponse(URL: response.URL!, statusCode: response.statusCode, HTTPVersion: "HTTP/1.1", headerFields: headers) {
                let newCachedResponse = NSCachedURLResponse(response: newHTTPURLResponse, data: cachedResponse.data)
                super.storeCachedResponse(newCachedResponse, forRequest: request)
        }
    }
}
