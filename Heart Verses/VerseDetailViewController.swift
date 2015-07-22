
import UIKit

class VerseDetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var detailItem: AnyObject? {
        didSet {
            self.configureView()
        }
    }

    func configureView() {
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.numberOfLines = 0
                label.text = detail.valueForKey("text")!.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

}

