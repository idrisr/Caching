// ViewController.swift
//  Created by id on 6/10/16.
//  Copyright © 2016 id. All rights reserved.

import UIKit

private let ResponseCollectionViewCellIdentifier = "ResponseCell"

class ViewController: UIViewController {
    var session: NSURLSession?
    @IBOutlet weak var collectionView: UICollectionView!

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

        registerCollectionViewCells()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: config)
        urls = dates.map({ NasaURL(date: $0).url})
    }

    @IBAction func refreshPressed(sender: AnyObject?) {
        self.collectionView.reloadData()
    }

    @IBAction func onClearCachePressed(sender: UIButton) {
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        self.refreshPressed(nil)
    }

    func registerCollectionViewCells() {
        collectionView?.registerNib(UINib(nibName: "ResponseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ResponseCollectionViewCellIdentifier)
    }
}

extension ViewController: UICollectionViewDelegate {

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ResponseCollectionViewCellIdentifier, forIndexPath: indexPath) as! ResponseCollectionViewCell
        let URL = self.urls![indexPath.row]
        cell.configure(URL)
        return cell
    }
}