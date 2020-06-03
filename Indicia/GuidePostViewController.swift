
import UIKit
import CoreData
import MapKit


class GuidePostViewController: UIViewController,UIScrollViewDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var metaDataView: UIView!
    @IBOutlet weak var metaDataViewTopContraint: NSLayoutConstraint!
   
        var selectedGuidePost : GuidePost!
    
    var delegate:GuidePostDelegate!
    var currentZoomScale : CGFloat = 1

  
    
//    @IBAction func buttonClick(sender: AnyObject) {
//        UIView.animateWithDuration(0.3,delay: 0.0,
//            options: .CurveEaseInOut, animations: { () -> Void in
//                self.metadataViewHeightConstraint.constant = 223
//            }, completion: nil)
//
//    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        currentZoomScale = 2
    }
    
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        currentZoomScale = scale
    }

    override func viewWillAppear(_ animated: Bool) {
        
        imageView.image = selectedGuidePost.getImageFromData()
        let size = imageView.image!.size
        let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        imageView.frame = frame
        
        scrollView.contentSize = CGSize(width: size.height, height: size.width)

    }
    
    override func viewDidAppear(_ animated: Bool) {
//        UIView.animateWithDuration(1.8,delay: 0,
//            options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//                self.metaDataViewTopContraint.constant = 377
//        
//            }, completion: nil)
        
   //     self.metaDataViewTopContraint.constant = 377
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coord = CLLocationCoordinate2DMake(selectedGuidePost.latitiude as! CLLocationDegrees, selectedGuidePost.longitude as! CLLocationDegrees)
        mapView.centerCoordinate = coord
        
        let region = MKCoordinateRegion(
            center: mapView.centerCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        mapView.setRegion(region, animated: true)
        
        
        
        
       // metaDataViewTopContraint.constant = self.view.frame.height
               scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(scrollViewDoubleTapped))
        
        //let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: Selector("scrollViewDoubleTapped:"))
                    doubleTapRecognizer.numberOfTapsRequired = 2
                    doubleTapRecognizer.numberOfTouchesRequired = 1
                    scrollView.addGestureRecognizer(doubleTapRecognizer)
    }
    @objc func scrollViewDoubleTapped() {
           currentZoomScale = (currentZoomScale == 1) ? 2 : 1
           scrollView.setZoomScale(currentZoomScale, animated: true)

         }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



