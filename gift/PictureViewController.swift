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
    
//    @IBAction func addImage() {
//        var picker = UIImagePickerController()
//        picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
//        picker.delegate = self
//        self.presentViewController(picker, animated: true, completion: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var query = PFQuery(className:"Pictures")
        var objects = query.findObjects()
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
            var objects = query.findObjects()
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

    //
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
//        var gameScore = PFObject(className: "Pictures")
//        var imageData = UIImagePNGRepresentation(info[UIImagePickerControllerOriginalImage] as UIImage)
//        var file = PFFile(data: imageData)
//        gameScore.setObject(file, forKey: "Picture")
//        picker.dismissViewControllerAnimated(true, completion: nil)
//        gameScore.saveInBackgroundWithBlock {
//            (success: Bool!, error: NSError!) -> Void in
//            if success {
//                self.reload = true
//                NSLog("Object created with id: \(gameScore.objectId)")
//            } else {
//                NSLog("%@", error)
//            }
//        }
//    }
    
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

