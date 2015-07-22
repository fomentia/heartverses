
import Foundation
import UIKit

class AddVerseViewController: UIViewController {

    @IBOutlet var errorText: UILabel!
    @IBOutlet var passageRequest: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
//    let heartVersesAPI = HeartVersesAPI(moc: self.appDelegate.managedObjectContext)

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.hidden = true
        errorText.numberOfLines = 0
        errorText.hidden = true
    }

    @IBAction func addVerse(sender: AnyObject) {
        if passageRequest.hasText() {
            activityIndicator.hidden = false
            activityIndicator.startAnimating()
            
            let heartVersesAPI = HeartVersesAPI(moc: self.appDelegate.managedObjectContext!)
            heartVersesAPI.loadVerse(passageRequest.text, completion: { (UIBackgroundFetchResult) in
                self.activityIndicator.stopAnimating()
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }
    }

    @IBAction func cancelAddVerse(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}