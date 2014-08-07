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
    @IBOutlet var picture : UIImageView!
    var _pictures = NSMutableArray()

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

        // get random picture with word of day
        var query2 = PFQuery(className:"DailyPictures")
        query2.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if !error {
//                NSLog("Got all objects")
//                NSLog("\n\n\n%@", objects[0] as PFObject)
//                NSLog("%@", objects.count)
//                self._pictures.addObject(objects[0])
                //                    for object : PFObject! in objects {
                //                        NSLog("Got:", object.objectForKey("id"))
                //                    }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

