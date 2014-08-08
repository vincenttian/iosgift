//
//  ActivitySuggestorController.m
//  gift
//
//  Created by Tian, Vincent on 8/7/14.
//  Copyright (c) 2014 vincenttian. All rights reserved.
//

#import "ActivitySuggestorController.h"
#import <Foundation/Foundation.h>
#import "YPAPISample.h"
#import <CoreLocation/CoreLocation.h>

@interface ActivitySuggestorController ()

@end

@implementation ActivitySuggestorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // get lat long
    CLLocationCoordinate2D coordinate = [self getLocation];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    // convert lat long from string to double
    NSString *latcutstring = [latitude substringFromIndex:1];
    NSString *loncutstring = [longitude substringFromIndex:1];
    double latdouble = [latcutstring doubleValue];
    double londouble = [loncutstring doubleValue];
//    NSLog(@"dLatitude : %f", latdouble);
//    NSLog(@"dLongitude : %f",londouble);
    
    // get city and country from lat long
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *loc = [[CLLocation alloc]initWithLatitude:latdouble longitude:londouble];
    [ceo reverseGeocodeLocation: loc completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         CLPlacemark *placemark = [placemarks objectAtIndex:0];
//         NSLog(@"city: %@",placemark.locality); // Extract the city name
//         NSLog(@"country %@",placemark.country);  // Give Country Name

         // recommend restaurants from yelp API
         YPAPISample *APISample = [[YPAPISample alloc] init];
         [APISample queryTopBusinessInfoForTerm:@"restaurant" location:@"San Francisco" completionHandler:^(NSDictionary *notNeeded, NSError *results) {
             if (results) {
                 NSLog(@"%@", results);
             } else {
                 NSLog(@"No business was found");
             }
         }];
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CLLocationCoordinate2D) getLocation{
    CLLocationManager *locationManager = [[[CLLocationManager alloc] init] autorelease];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    return coordinate;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
