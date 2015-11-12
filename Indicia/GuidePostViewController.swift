
import UIKit
import CoreData


class GuidePostViewController: UIViewController,UIScrollViewDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedGuidePost : GuidePost!
    
    var delegate:GuidePostDelegate!
    var currentZoomScale : CGFloat = 1

    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        currentZoomScale = (currentZoomScale == 1) ? 2 : 1
        scrollView.setZoomScale(currentZoomScale, animated: true)
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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



