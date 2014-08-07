//
//  ActivitySuggestorController.swift
//  gift
//
//  Created by Tian, Vincent on 8/5/14.
//  Copyright (c) 2014 vincenttian. All rights reserved.
//

import UIKit
import CoreLocation

class ActivitySuggestorController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // code to find user location
        var locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

//        NSLog("l%@", locationManager)


        // code to work with yelp API
        var URL = "http://api.yelp.com/v2/search?term=restaurants&location=new%20york";
//        var consumer = 


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // trying to get location of current user
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        NSLog("locations = \(locations)")
    }


}

