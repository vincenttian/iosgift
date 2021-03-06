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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        Flurry.logEvent("Went to picture list view page")
        
        var query = PFQuery(className:"Pictures")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if !error {
                self._objects = NSMutableArray()
                var counter = objects.count - 1
                for index in 0...counter {
                    var currObj = objects[index] as PFObject
                    var currImageFile = currObj["Picture"] as PFFile
                    currImageFile.getDataInBackgroundWithBlock {
                        (imageData: NSData!, error: NSError!) -> Void in
                        if !error {
                            var image = UIImage(data:imageData)
                            self._objects.addObject(image)
                        }
                        if index == counter {
                            self.tableView.reloadData()
                            // move tableview down a little
                            self._tableView.setContentOffset(CGPoint(x:0, y:-50), animated: true)

                        }
                    }
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
        var currImage = self._objects[indexPath.row] as UIImage
        cell.imageView.image = currImage
        return cell
    }
    
    
}

