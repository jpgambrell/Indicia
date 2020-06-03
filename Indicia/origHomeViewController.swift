//
//  HomeViewController.swift
//  Indicia
//
//  Created by Gambrell, John on 4/3/15.
//  Copyright (c) 2015 Gambrell, John. All rights reserved.
//

import UIKit
import CoreData



// /,*UICollectionViewDataSource*/
class origHomeViewController: UITableViewController,UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate, GuidePostDelegate{

    
    @IBOutlet weak var photoStripCollectionView: UICollectionView!
   

    var guidePostArray = [NSDictionary]();
    var collectionCellData = [NSDictionary]()    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // guidePostArray = DataModelController.sharedInstance.fetchGuidePostsForCollectionView() as! [(NSDictionary)]
        refreshGuidePostDataArray()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if (segue.identifier == "gpPopOverSegue"){
                   let gpPopOverVC = segue.destination as! GuidePostPopOverViewController
                   gpPopOverVC.modalPresentationStyle = UIModalPresentationStyle.popover
                   gpPopOverVC.popoverPresentationController!.delegate = self
                   gpPopOverVC.delegate = self;
               }
    }
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "gpPopOverSegue"){
//            let gpPopOverVC = segue.destination as! GuidePostPopOverViewController
//            gpPopOverVC.modalPresentationStyle = UIModalPresentationStyle.popover
//            gpPopOverVC.popoverPresentationController!.delegate = self
//            gpPopOverVC.delegate = self;
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return false
    }
    
    
   override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 0
    }
    
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: \(guidePostArray)")
        return guidePostArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCategoryTableCell")as! PhotoCategoryTableViewCell

               let gp = guidePostArray[indexPath.row] as NSDictionary
               cell.categoryLabel.text = gp["sectionTitle"] as? String
               cell.collectionCellData = gp["collectionData"] as? NSArray
               cell.collectionView.reloadData()
               
               return cell
    }
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCategoryTableCell")as! PhotoCategoryTableViewCell
//
//        let gp = guidePostArray[indexPath.row] as NSDictionary
//        cell.categoryLabel.text = gp["sectionTitle"] as? String
//        cell.collectionCellData = gp["collectionData"] as? NSArray
//        cell.collectionView.reloadData()
//
//        return cell
//    }
    
    
    func guidePostAdded() {
        refreshGuidePostDataArray()
        
    }

//    func popoverPresentationControllerShouldDismissPopover(popoverPresentationController: UIPopoverPresentationController) -> Bool {
//        return false
//    }
    
    func refreshGuidePostDataArray(){
        guidePostArray = DataModelController.sharedInstance.fetchGuidePostsForCollectionView() as! [(NSDictionary)]
       DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        

    }
    
}
