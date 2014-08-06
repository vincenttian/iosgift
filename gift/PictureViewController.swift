//
//  PictureViewController.swift
//  gift
//
//  Created by Tian, Vincent on 8/5/14.
//  Copyright (c) 2014 vincenttian. All rights reserved.
//

import UIKit

class PictureViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    var reload = false
    @IBOutlet var picture : UIImageView!
    @IBOutlet var _tableView : UITableView!
    var _objects = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var query = PFQuery(className:"Pictures")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if !error {
//                NSLog("Got all objects")
                NSLog("\n\n\n%@", objects[0] as PFObject)
                self._objects.addObject(objects[0])
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
    
    override func viewDidAppear(animated: Bool) {
        if reload == true {
            var query = PFQuery(className:"Pictures")
            reload = false
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]!, error: NSError!) -> Void in
                if !error {
//                    NSLog("Got all objects")
                    NSLog("\n\n\n%@", objects[0] as PFObject)
                }
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return _objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        NSLog("%@", tableView)
//        if tableView == self.searchDisplayController.searchResultsTableView {
//            let object =
//            cell.textLabel.text = ""
//        } else {
//            let object =
//            cell.textLabel.text = ""
//        }
        return cell
    }
    
    
}

