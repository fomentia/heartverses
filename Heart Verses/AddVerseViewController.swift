//
//  AddVerseViewController.swift
//  Heart Verses
//
//  Created by Isaac Williams on 7/20/15.
//  Copyright (c) 2015 Isaac Williams. All rights reserved.
//

import Foundation
import UIKit

class AddVerseViewController: UIViewController {

    @IBOutlet var errorText: UILabel!
    @IBOutlet var passageRequest: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancelAddVerse(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addVerse(sender: AnyObject) {
    }

}