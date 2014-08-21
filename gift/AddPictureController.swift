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

    override func viewDidAppear(animated: Bool) {
        Flurry.logEvent("Went to add picture page")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        var gameScore = PFObject(className: "Pictures")
        var image = info[UIImagePickerControllerOriginalImage] as UIImage

        // trying to fix image orientation
        image = fixImage(image)
        
        var imageData = UIImagePNGRepresentation(image)
        var imageSize = imageData.length
        var file = PFFile(data: imageData)
        gameScore.setObject(file, forKey: "Picture")
        picker.dismissViewControllerAnimated(true, completion: nil)
        if imageSize < 10485760 {
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
    
    func fixImage(image: UIImage) -> UIImage {
        if image.imageOrientation == UIImageOrientation.Up {
            return image
        }
        var transform = CGAffineTransformIdentity
        switch (image.imageOrientation) {
            case UIImageOrientation.Down:
                transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height)
                transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
                break
            case UIImageOrientation.DownMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height)
                transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
                break
            case UIImageOrientation.Left:
                transform = CGAffineTransformTranslate(transform, image.size.width, 0)
                transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
                break
            case UIImageOrientation.LeftMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.width, 0)
                transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
                break
            case UIImageOrientation.Right:
                transform = CGAffineTransformTranslate(transform, 0, image.size.height)
                transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
                break
            case UIImageOrientation.RightMirrored:
                transform = CGAffineTransformTranslate(transform, 0, image.size.height)
                transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
                break
            case UIImageOrientation.Up:
                break
            case UIImageOrientation.UpMirrored:
                break
        }
        switch (image.imageOrientation) {
            case UIImageOrientation.Up:
                transform = CGAffineTransformTranslate(transform, image.size.width, 0)
                transform = CGAffineTransformScale(transform, -1, 1)
                break
            case UIImageOrientation.UpMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.width, 0)
                transform = CGAffineTransformScale(transform, -1, 1)
                break
            case UIImageOrientation.LeftMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.height, 0)
                transform = CGAffineTransformScale(transform, -1, 1)
                break
            case UIImageOrientation.RightMirrored:
                transform = CGAffineTransformTranslate(transform, image.size.height, 0)
                transform = CGAffineTransformScale(transform, -1, 1)
                break
            case UIImageOrientation.Up:
                break
            case UIImageOrientation.Down:
                break
            case UIImageOrientation.Left:
                break
            case UIImageOrientation.Right:
                break
            default:
                break
        }
        var ctx = CGBitmapContextCreate(nil, UInt(image.size.width), UInt(image.size.height), CGImageGetBitsPerComponent(image.CGImage), 0, CGImageGetColorSpace(image.CGImage), CGImageGetBitmapInfo(image.CGImage))
        CGContextConcatCTM(ctx, transform)
        switch (image.imageOrientation) {
            case UIImageOrientation.Left:
                CGContextDrawImage(ctx, CGRectMake(0, 0, image.size.height, image.size.width), image.CGImage)
                break
            case UIImageOrientation.LeftMirrored:
                CGContextDrawImage(ctx, CGRectMake(0, 0, image.size.height, image.size.width), image.CGImage)
                break
            case UIImageOrientation.Right:
                CGContextDrawImage(ctx, CGRectMake(0, 0, image.size.height, image.size.width), image.CGImage)
                break
            case UIImageOrientation.RightMirrored:
                CGContextDrawImage(ctx, CGRectMake(0, 0, image.size.height, image.size.width), image.CGImage)
                break
            default:
                CGContextDrawImage(ctx, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage)
                break
        }
        var cgimg = CGBitmapContextCreateImage(ctx)
        var img = UIImage(CGImage: cgimg)
        return img
    }
    
}

