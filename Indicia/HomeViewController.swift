//
//  HomeViewController.swift
//  Indicia
//
//  Created by Gambrell, John on 7/23/15.
//  Copyright (c) 2015 Gambrell, John. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, GuidePostDelegate {

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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if (segue.identifier == "gpPopOverSegue"){
            let gpPopOverVC = segue.destination as! GuidePostPopOverViewController
            gpPopOverVC.modalPresentationStyle = UIModalPresentationStyle.popover
                   gpPopOverVC.popoverPresentationController!.delegate = self
                   gpPopOverVC.delegate = self;
               }
               
             
               if (segue.identifier == "gpDetailSegue"){
                let   gpDetailVC = segue.destination as! GuidePostViewController
                         gpDetailVC.delegate = self;
               
                let iPath = collectionView.indexPath(for: sender as! PhotoCategoryCollectionViewCell)
                   gpDetailVC.selectedGuidePost = guidePostArray[iPath!.row]
               }
    }
   

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return false
    }
    // MARK: - CollectionView Methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guidePostArray.count
        //return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCategoryCollectionCell", for: indexPath as IndexPath) as! PhotoCategoryCollectionViewCell
        let gp = guidePostArray[indexPath.row] as GuidePost
       
        cell.imageView.image = gp.getImageFromData()
//        cell.imageView.image = UIImage(named: "wall.jpg")
       
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("Collection View Size class: \(traitCollection.horizontalSizeClass.rawValue)")
           print("Collection View Bounds: \(collectionView.bounds)")
           
           
           let numberOfColumns = (collectionView.bounds.width > 415) ? 3 : 2 as CGFloat
           let width = collectionView.bounds.width / numberOfColumns  - 15  as CGFloat
           
           switch traitCollection.horizontalSizeClass {
           case .compact: return CGSize(width: width, height: width)
           case .regular:  return CGSize(width: width, height: width)
           default:  return CGSize(width: width, height: width)
           }
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          print("clicked at indexpath: \(indexPath)")
    }
    

    
     // MARK: - GuidePost Delegate Methods
    func guidePostAdded() {
         guidePostArray = DataModelController.sharedInstance.fetchAllGuidePosts()
        collectionView.reloadData()
        
        
    }
}
