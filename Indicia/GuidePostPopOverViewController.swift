import UIKit
import CoreData
import CoreLocation

class GuidePostPopOverViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate {
    var imagePicker = UIImagePickerController()
    var locationManager : CLLocationManager!
    var currentLocation : CLLocation!
    var delegate: GuidePostDelegate!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gpTagTextField: UITextField!
    
    @IBOutlet weak var gpTypeSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        let imageName = "\(NSDate().timeIntervalSince1970).png"
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let destinationPath = documentsPath.stringByAppendingPathComponent(imageName)
        UIImageJPEGRepresentation(imageView.image!,1.0)!.writeToFile(destinationPath, atomically: true)
        
        let gpStruct = GuidePostStruct(imageName: imageName, type: gpTypeSegment.selectedSegmentIndex, tags: gpTagTextField.text!, location: currentLocation, date: NSDate())
        
        if DataModelController.sharedInstance.insertGuidepost(gpStruct) == CDResponse.Success {
            delegate!.guidePostAdded()
            self.dismissViewControllerAnimated(
                true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Something went wrong", message: "Unable to Save", preferredStyle: .Alert)
            self.presentViewController(alert, animated: true, completion: nil)
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
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Current location: \(location)")
            currentLocation = location
        } else {
            // ...
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error finding location: \(error.localizedDescription)")
    }

}





