//
//  GuidePost.swift
//  Indicia
//
//  Created by Gambrell, John on 5/11/15.
//  Copyright (c) 2015 Gambrell, John. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class GuidePost: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var descriptionText: String
    @NSManaged var imageName: String
    @NSManaged var latitiude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var tags: String
    @NSManaged var type: NSNumber
    
    func getImageFromData()-> UIImage{
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
  
       // let destinationPath = documentsPath.stringByAppendingPathComponent(imageName)
        
        guard let destinationPath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent(imageName) else { return UIImage() }

      
        if let imageFromFile = UIImage(data: NSData(contentsOf: destinationPath)! as Data){
            return imageFromFile
        }
        
        return UIImage(named: "wall.jpg")!
        
    }
}
extension String{
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.appendingPathComponent(path)
    }
}
