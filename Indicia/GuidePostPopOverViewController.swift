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
       
      //  let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
      //  let destinationPath = documentsPath.stringByAppendingPathComponent(path: imageName)
        
         let imageName = "\(NSDate().timeIntervalSince1970).png"
        if let data = imageView.image!.pngData() {
            
               let filename = getDocumentsDirectory().appendingPathComponent(imageName)
               
               try? data.write(to: filename)
           }
        
        
        //UIImageJPEGRepresentation(imageView.image!,1.0)!.writeToFile(destinationPath, atomically: true)
        
        let gpStruct = GuidePostStruct(imageName: imageName, type: gpTypeSegment.selectedSegmentIndex, tags: gpTagTextField.text!, location: currentLocation, date: NSDate())
        
        if DataModelController.sharedInstance.insertGuidepost(inGP: gpStruct) == CDResponse.Success {
            delegate!.guidePostAdded()
            self.dismiss(
                animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Something went wrong", message: "Unable to Save", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    func presentImagePickerController(sourceType: UIImagePickerController.SourceType){
        
        imagePicker.delegate = self;
        imagePicker.sourceType  = sourceType
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func takePhotoPressed(sender: AnyObject) {
        presentImagePickerController(sourceType: .camera)
    }
    
    @IBAction func choosePhotoButtonPressed(sender: AnyObject) {
        presentImagePickerController(sourceType: .photoLibrary)
    }
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
        }

        self.imagePicker.dismiss(animated: true, completion: nil)
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
//       
//         DispatchQueue.main.async {
//            self.imageView.image = image
//            self.imagePicker.dismiss(animated: true, completion: nil)
//               }
//       
//    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Current location: \(location)")
            currentLocation = location
        } else {
            // ...
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error finding location: \(error.localizedDescription)")
    }
    

}





