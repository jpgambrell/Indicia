//
//  HomeViewController.swift
//  Indicia
//
//  Created by Gambrell, John on 7/23/15.
//  Copyright (c) 2015 Gambrell, John. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate, GuidePostDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
     var guidePostArray = [GuidePost]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guidePostArray = DataModelController.sharedInstance.fetchAllGuidePosts()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "gpPopOverSegue"){
            let gpPopOverVC = segue.destinationViewController as! GuidePostPopOverViewController
            gpPopOverVC.modalPresentationStyle = UIModalPresentationStyle.Popover
            gpPopOverVC.popoverPresentationController!.delegate = self
            gpPopOverVC.delegate = self;
        }
        
      
        if (segue.identifier == "gpDetailSegue"){
            let   gpDetailVC = segue.destinationViewController as! GuidePostViewController
                  gpDetailVC.delegate = self;
        
            let iPath = collectionView.indexPathForCell(sender as! PhotoCategoryCollectionViewCell)
            gpDetailVC.selectedGuidePost = guidePostArray[iPath!.row]
        }
        
    }

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return false
    }
    // MARK: - CollectionView Methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guidePostArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCategoryCollectionCell", forIndexPath: indexPath) as! PhotoCategoryCollectionViewCell
        let gp = guidePostArray[indexPath.row] as GuidePost
       
        cell.imageView.image = gp.getImageFromData()
     
        return cell

    }
    
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("clicked at indexpath: \(indexPath)")

    }

    
     // MARK: - GuidePost Delegate Methods
    func guidePostAdded() {
         guidePostArray = DataModelController.sharedInstance.fetchAllGuidePosts()
        collectionView.reloadData()
        
        
    }
}
