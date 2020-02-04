// ViewController.swift
//  Created by id on 6/10/16.
//  Copyright © 2016 id. All rights reserved.

import UIKit

private let ResponseCollectionViewCellIdentifier = "ResponseCell"

class ViewController: UIViewController {
    var session: URLSession?
    @IBOutlet weak var collectionView: UICollectionView!

    let dates = [
        "2015-05-01", "2015-05-02", "2015-05-03", "2015-05-04", "2015-05-05",
        "2015-05-06", "2015-05-07", "2015-05-08", "2015-05-09", "2015-05-10",
        "2015-05-11", "2015-05-12", "2015-05-13", "2015-05-14", "2015-05-15",
        "2015-05-16", "2015-05-17", "2015-05-18", "2015-05-19", "2015-05-20",
        "2015-05-21", "2015-05-22", "2015-05-23", "2015-05-24", "2015-05-25",
        "2015-05-26", "2015-05-27", "2015-05-28", "2015-05-29", "2015-05-30", "2015-05-31"]

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCells()
        self.collectionView.dataSource = self

        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }

    @IBAction func refreshPressed(_ sender: AnyObject?) {
        self.collectionView.reloadData()
    }

    @IBAction func onClearCachePressed(_ sender: UIButton) {
        URLCache.shared.removeAllCachedResponses()
    }

    func registerCollectionViewCells() {
        collectionView?.register(UINib(nibName: "ResponseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ResponseCollectionViewCellIdentifier)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResponseCollectionViewCellIdentifier, for: indexPath) as! ResponseCollectionViewCell
        let date = self.dates[indexPath.row]
        cell.configure(date)
        return cell
    }
}
