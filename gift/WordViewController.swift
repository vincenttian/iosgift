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
                    self.words.text = "No daily words yet! Come back in a little!"
                } else {
                    var numObj = objects.count
                    var tmpObj = objects[numObj-1] as PFObject
                    self.words.text = tmpObj["text"] as String
                }
            } else {
                // Log details of the failure
                NSLog("Error: %@ %@", error, error.userInfo)
            }
        }
    }

    override func viewDidAppear(animated: Bool) {
        // get random picture with word of day
        var query2 = PFQuery(className:"Pictures")
        query2.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if !error {
                var numObj = objects.count
                var randomNumber = Int(arc4random()) % numObj
                var imageFile = objects[randomNumber]["Picture"] as PFFile
                imageFile.getDataInBackgroundWithBlock {
                    (imageData: NSData!, error: NSError!) -> Void in
                    if !error {
                        var image = UIImage(data:imageData)
                        self.picture.image = image
                    }
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

