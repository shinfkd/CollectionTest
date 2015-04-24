//
//  EventScrollViewController.swift
//  timeline
//
//  Created by Shin on 2015/04/23.
//  Copyright (c) 2015年 Shintaro Fukuda. All rights reserved.
//

import UIKit

class EventScrollViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var events = [NSDate : String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.whiteColor()
        generateEvents(NSDate())
        let nib: UINib = UINib(nibName: "EventCell", bundle: nil)
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }

    func generateEvents(currentDate: NSDate) {
        for i in 1...15 {
            let interval: NSTimeInterval = -60 * 60 * 24 * Double(i)
            events[currentDate.dateByAddingTimeInterval(interval)] = "hogehoge"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
//        let cell = UINib(nibName: "EventCell", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! EventCollectionViewCell
        println(indexPath)
//        cell.title.text = events[indexPath][0]
//        cell.content.text = events[indexPath][1]
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
