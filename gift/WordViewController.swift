//
//  WordViewController.swift
//  gift
//
//  Created by Tian, Vincent on 8/5/14.
//  Copyright (c) 2014 vincenttian. All rights reserved.
//

import UIKit

class WordViewController: UIViewController {

    @IBOutlet var words : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        NSLog("%@", "got to word view controller")

        // get word of day of last day
        let predicate = NSPredicate(format: "createdAt = ''")
        var query = PFQuery(className:"DailyWords", predicate: predicate)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

