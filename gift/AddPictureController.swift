//
//  AddPictureController.swift
//  gift
//
//  Created by Tian, Vincent on 8/5/14.
//  Copyright (c) 2014 vincenttian. All rights reserved.
//

import UIKit

class AddPictureController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var addPicture : UIButton!
    @IBOutlet var seePictures : UIButton!
    
    @IBAction func addImage() {
        var picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        var gameScore = PFObject(className: "Pictures")
        
        var image = info[UIImagePickerControllerOriginalImage] as UIImage
        var imageData = UIImagePNGRepresentation(image)
        var file = PFFile(data: imageData)
        gameScore.setObject(file, forKey: "Picture")
        picker.dismissViewControllerAnimated(true, completion: nil)
        gameScore.saveInBackgroundWithBlock {
            (success: Bool!, error: NSError!) -> Void in
            if success {
//                self.reload = true
                NSLog("Object created with id: \(gameScore.objectId)")
            } else {
                NSLog("%@", error)
            }
        }
    }
    
}

