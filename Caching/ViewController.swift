//  ViewController.swift
//  Created by id on 6/10/16.
//  Copyright © 2016 id. All rights reserved.

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // get the plist into a dict
        guard let data = NSArray(contentsOfFile: dataPath()) as? [String] else {
            return
        }

        let urls = data.map({NSURL(string: $0)})
        urls.map({makeRequest($0)})
    }

    private func dataPath() -> String {
        return NSBundle.mainBundle().pathForResource("urls", ofType: "plist")!
    }

    // make each request
    func makeRequest(URL: NSURL?) {
        print(URL!.absoluteString)
    }
}