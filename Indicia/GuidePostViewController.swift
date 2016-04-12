
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

    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        currentZoomScale = (currentZoomScale == 1) ? 2 : 1
        scrollView.setZoomScale(currentZoomScale, animated: true)

      }
    
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
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        currentZoomScale = 2
    }
    
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        currentZoomScale = scale
    }

    override func viewWillAppear(animated: Bool) {
        
        imageView.image = selectedGuidePost.getImageFromData()
        let size = imageView.image!.size
        let frame = CGRectMake(0, 0, size.width, size.height)
        imageView.frame = frame
        
        scrollView.contentSize = CGSizeMake(size.height, size.width)

    }
    
    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(1.8,delay: 0,
//            options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//                self.metaDataViewTopContraint.constant = 377
//        
//            }, completion: nil)
        
   //     self.metaDataViewTopContraint.constant = 377
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coord = CLLocationCoordinate2DMake(selectedGuidePost.latitiude as CLLocationDegrees, selectedGuidePost.longitude as CLLocationDegrees)
        mapView.centerCoordinate = coord
        
        let region = MKCoordinateRegionMakeWithDistance(
           mapView.centerCoordinate, 1000, 1000)
        
        mapView.setRegion(region, animated: true)
        
        
        
        
       // metaDataViewTopContraint.constant = self.view.frame.height
               scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:")
                    doubleTapRecognizer.numberOfTapsRequired = 2
                    doubleTapRecognizer.numberOfTouchesRequired = 1
                    scrollView.addGestureRecognizer(doubleTapRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



