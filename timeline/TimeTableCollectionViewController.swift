//
//  TimeTableCollectionViewController.swift
//  timeline
//
//  Created by Shintaro Fukuda on 2015/04/24.
//  Copyright (c) 2015年 Shintaro Fukuda. All rights reserved.
//

import UIKit

let reuseIdentifier = "TimeCell"

class TimeTableCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    var timeTables = Array<NSDate>()

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        generateTimeTable()

        let nib = UINib(nibName: "TimeTableCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeTables.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TimeTableCollectionViewCell
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:00"
        cell.time.text = formatter.stringFromDate(timeTables[indexPath.row])
        return cell
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffsetWidthWindow = self.collectionView.contentOffset.y + self.collectionView.bounds.size.height
        if contentOffsetWidthWindow >= self.collectionView.contentSize.height {
            generateTimeTable()
            self.collectionView.reloadData()
        }
    }

    func generateTimeTable() {
        var date: NSDate
        if timeTables.count == 0 {
            date = NSDate()
        } else {
            date = timeTables[timeTables.endIndex - 1]
        }
        for i in 1...24 {
            var interval = -60 * 60 * Double(i)
            timeTables.append(date.dateByAddingTimeInterval(interval))
        }
    }
}
