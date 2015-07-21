
import Foundation
import UIKit

class AddVerseViewController: UIViewController {

    @IBOutlet var errorText: UILabel!
    @IBOutlet var passageRequest: UITextField!
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
//    let heartVersesAPI = HeartVersesAPI(moc: self.appDelegate.managedObjectContext)

    override func viewDidLoad() {
        super.viewDidLoad()

        errorText.numberOfLines = 0
        errorText.hidden = true
    }

    @IBAction func addVerse(sender: AnyObject) {
        if passageRequest.hasText() {
            let heartVersesAPI = HeartVersesAPI(moc: self.appDelegate.managedObjectContext!)
            heartVersesAPI.loadVerse(passageRequest.text)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    @IBAction func cancelAddVerse(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}