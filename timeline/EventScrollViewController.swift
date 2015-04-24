//
//  EventScrollViewController.swift
//  timeline
//
//  Created by Shin on 2015/04/23.
//  Copyright (c) 2015年 Shintaro Fukuda. All rights reserved.
//

import UIKit

struct CellData {
    var title: NSDate
    var content: String
    init(title: NSDate, content: String) {
        self.title = title
        self.content = content
    }
}

class EventScrollViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var events = Array<CellData>()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.whiteColor()
        generateEvents(NSDate())
        let nib = UINib(nibName: "EventCollectionViewCell", bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }

    func generateEvents(currentDate: NSDate) {
        for i in 1...15 {
            let interval: NSTimeInterval = -60 * 60 * 24 * Double(i)
            let date = currentDate.dateByAddingTimeInterval(interval)
            let data = CellData(title: date, content: "hogehoge")
            events.append(data)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! EventCollectionViewCell
        let event = events[indexPath.row]
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        cell.title.text = formatter.stringFromDate(event.title)
        cell.content.text = event.content
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffsetWidthWindow = self.collectionView.contentOffset.y + self.collectionView.bounds.size.height
        if contentOffsetWidthWindow >= self.collectionView.contentSize.height {
            generateEvents(NSDate())
            self.collectionView.reloadData()
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
    }
}
