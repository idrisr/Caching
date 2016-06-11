//
//  ResponseTableViewCell.swift
//  Caching
//
//  Created by id on 6/10/16.
//  Copyright © 2016 id. All rights reserved.
//

import UIKit

enum HeaderFields: String {
    case Age
    case Connection
    case Date
    case XCache = "X-Cache"
    case XRateLimitRemaining = "X-RateLimit-Remaining"

    static let allFields = [Age, Connection, Date, XCache, XRateLimitRemaining]
}

class ResponseTableViewCell: UITableViewCell {
    @IBOutlet weak var responseLabel: UILabel!

    var response: NSURLResponse!
    var task: NSURLSessionDataTask?

    func configure(URL: NSURL) {
        self.task = NetworkClient.sharedInstance.getURLResponse(URL, completion: { (object, error) in
            guard error == nil else {
                print("\(error)")
                return
            }

            guard let response = object as? NSHTTPURLResponse else {
                print("not a http url response")
                return
            }

            let headers = response.allHeaderFields
            var a = [String]()
            for header in HeaderFields.allFields {
                a.append("\(header.rawValue) \(headers[header.rawValue]!)")
            }

            let b = a.joinWithSeparator("\n")
            self.responseLabel.text = b
        })
        task?.resume()
    }

    override func prepareForReuse() {
        if let task = task {
            task.cancel()
        }
        responseLabel.text = nil
    }
}
