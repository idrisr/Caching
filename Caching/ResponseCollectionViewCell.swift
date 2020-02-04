//
//  ResponseCollectionViewCell.swift
//  Caching
//
//  Created by id on 6/11/16.
//  Copyright © 2016 id. All rights reserved.
//

import UIKit

enum HeaderFields: String {
    case Age
    case Connection
    case Date
    case XCache = "X-Cache"
    case XRateLimitRemaining = "X-RateLimit-Remaining"
}

class ResponseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var response: URLResponse!
    var task: URLSessionDataTask?

    func configure(_ date: String) {
        let URL = NasaURL(date: date).url
        spinner.startAnimating()

        self.task = NetworkClient.sharedInstance.getURLResponse(URL, completion: { (object, error) in
            self.spinner.stopAnimating()
            guard error == nil else {
                print("\(String(describing: error))")
                return
            }

            guard let response = object as? HTTPURLResponse else {
                print("not a http url response")
                return
            }

            if let apiRemaining = response.allHeaderFields[HeaderFields.XRateLimitRemaining.rawValue] as? String {
                self.responseLabel.text = apiRemaining
                let day = date.suffix(5)
                self.dateLabel.text = String(day)
            }
        })
        task?.resume()
    }

    override func prepareForReuse() {
        if let task = task {
            task.cancel()
        }

        responseLabel.text = nil
        dateLabel.text = nil
    }
}
