//
//  PhotoCategoryTableViewCell.swift
//  Indicia
//
//  Created by Gambrell, John on 4/3/15.
//  Copyright (c) 2015 Gambrell, John. All rights reserved.
//

import UIKit

class PhotoCategoryTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCategoryCollectionCell", for: indexPath as IndexPath) as! PhotoCategoryCollectionViewCell
                //PhotoCategoryCollectionCell
                cell.backgroundColor = UIColor.black
        //
        //        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        //
        //        let gp = collectionCellData[indexPath.row] as? GuidePost
        //        let destinationPath = documentsPath.stringByAppendingPathComponent(gp!.imageName)
        //
        //        cell.imageView.image = UIImage(contentsOfFile: destinationPath)
                
                cell.imageView.image = UIImage(named: "wall.jpg")
                
                
                
                return cell
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var collectionCellData :NSArray!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return (collectionCellData != nil) ? collectionCellData.count:0
        return 20
    }
    
//    private func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCategoryCollectionCell", for: indexPath as IndexPath) as! PhotoCategoryCollectionViewCell
//        //PhotoCategoryCollectionCell
//        cell.backgroundColor = UIColor.black
////
////        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
////
////        let gp = collectionCellData[indexPath.row] as? GuidePost
////        let destinationPath = documentsPath.stringByAppendingPathComponent(gp!.imageName)
////
////        cell.imageView.image = UIImage(contentsOfFile: destinationPath)
//
//        cell.imageView.image = UIImage(named: "wall.jpg")
//
//
//
//        return cell
//    }

    
    private func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("clicked at indexpath: \(indexPath) - \(collectionCellData.count)")
    }
    
//     func setCollectionCellData(data:NSArray){
//            println("did this work?")
//        collectionCellData = data;
//        collectionView.reloadData()
//    }

}
