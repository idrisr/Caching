// ViewController.swift
//  Created by id on 6/10/16.
//  Copyright © 2016 id. All rights reserved.

import UIKit

class ViewController: UIViewController {
    var session: NSURLSession?

    @IBOutlet weak var tableView: UITableView!
    let dates = [ "2015-05-01", "2015-05-02", "2015-05-03", "2015-05-04",
        "2015-05-05", "2015-05-06", "2015-05-07", "2015-05-08", "2015-05-09",
        "2015-05-10", "2015-05-11", "2015-05-12", "2015-05-13", "2015-05-14",
        "2015-05-15", "2015-05-16", "2015-05-17", "2015-05-18", "2015-05-19",
        "2015-05-20", "2015-05-11", "2015-05-22", "2015-05-23", "2015-05-24",
        "2015-05-25", "2015-05-26", "2015-05-27", "2015-05-28", "2015-05-29",
        "2015-05-30"] 

    var urls: [NSURL]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self

        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config)
        urls = dates.map({ NasaURL(date: $0).url})
    }

    @IBAction func refreshPressed(sender: AnyObject?) {
        self.tableView.reloadData()
    }

    @IBAction func onClearCachePressed(sender: UIButton) {
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        self.refreshPressed(nil)
    }

    // make each request
    func makeRequest(URL: NSURL?) {
        guard let URL = URL else {
            return
        }

        let request = NSURLRequest(URL: URL)
        let task = self.session?.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            if error == nil {
                guard let httpResponse = response as? NSHTTPURLResponse else {
                    return
                }

                guard httpResponse.statusCode == 200 else {
                    return
                }
                print("\(response)")

            } else {
                print(error?.localizedDescription)
            }

        })
        task?.resume()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseID = "responseCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseID, forIndexPath: indexPath) as? ResponseTableViewCell
        let URL = self.urls![indexPath.row]
        cell!.configure(URL)
        return cell!
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
}
