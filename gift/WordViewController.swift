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
        // Do any additional setup after loading the view, typically from a nib.


        // get word of day of today
        let today = NSDate()
        let beginToday = today.dateByAddingTimeInterval(-86400)
        var query = PFQuery(className:"DailyWords")
        query.whereKey("createdAt", greaterThan:beginToday)
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if !error { // success
                if objects.count == 0 {
                    NSLog("%@", "got here")
                    self.words.text = "No Daily words yet! Come back in a little!"
                } else {
                    NSLog("%@", objects[0] as PFObject)
                    var tmpObj = objects[0] as PFObject
//                NSLog("%@", objects[0].objectForKey("text"))
                    self.words.text = "got here success!!"
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

