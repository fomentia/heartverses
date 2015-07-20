
import Foundation
import UIKit

class AddVerseViewController: UIViewController {

    @IBOutlet var errorText: UILabel!
    @IBOutlet var passageRequest: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        errorText.numberOfLines = 0
        errorText.hidden = true
    }

    @IBAction func addVerse(sender: AnyObject) {
    }

    @IBAction func cancelAddVerse(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}