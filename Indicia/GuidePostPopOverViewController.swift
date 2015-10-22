//
//  GuidePostPopOverViewController.swift
//  Indicia
//
//  Created by Gambrell, John on 5/10/15.
//  Copyright (c) 2015 Gambrell, John. All rights reserved.
//

import UIKit
import CoreData




class GuidePostPopOverViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var imagePicker = UIImagePickerController();
    
    var delegate: GuidePostDelegate!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gpTagTextField: UITextField!
    
    @IBOutlet weak var gpTypeSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {

        
        print("seg: \(gpTypeSegment.selectedSegmentIndex)")
        
        let imageName = "\(NSDate().timeIntervalSince1970).png"
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] 
        let destinationPath = documentsPath.stringByAppendingPathComponent(imageName)
        UIImageJPEGRepresentation(imageView.image!,1.0)!.writeToFile(destinationPath, atomically: true)
        
        
        let managedContext = DataModelController.sharedInstance.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("GuidePost", inManagedObjectContext: managedContext)
        
        let gp = GuidePost(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        gp.imageName = imageName
        gp.type = gpTypeSegment.selectedSegmentIndex
        gp.tags = gpTagTextField.text!
        gp.date = NSDate()
 
      
        do {
            try managedContext.save()
            delegate!.guidePostAdded()
            self.dismissViewControllerAnimated(
                true, completion: nil)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
            
        }
        
        
    }

    
    func presentImagePickerController(sourceType: UIImagePickerControllerSourceType){
        
        imagePicker.delegate = self;
        imagePicker.sourceType  = sourceType
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func takePhotoPressed(sender: AnyObject) {
      presentImagePickerController(.Camera)
    }
    
    @IBAction func choosePhotoButtonPressed(sender: AnyObject) {
        presentImagePickerController(.PhotoLibrary)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = image
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

