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
                 
                 // business1
                 NSLog(@"name: %@",[[results objectAtIndex:0] objectForKey:@"name"]);
                 NSLog(@"rating: %@",[[results objectAtIndex:0] objectForKey:@"rating"]);
                 NSLog(@"address: %@",[[[[results objectAtIndex:0] objectForKey:@"location"] objectForKey:@"address"] objectAtIndex:0]);
                 NSLog(@"reviews: %@",[[results objectAtIndex:0] objectForKey:@"review_count"]);
                 NSLog(@"url: %@",[[results objectAtIndex:0] objectForKey:@"url"]);

                 // business2
                 NSLog(@"name: %@",[[results objectAtIndex:1] objectForKey:@"name"]);
                 NSLog(@"rating: %@",[[results objectAtIndex:1] objectForKey:@"rating"]);
                 NSLog(@"address: %@",[[[[results objectAtIndex:1] objectForKey:@"location"] objectForKey:@"address"] objectAtIndex:0]);
                 NSLog(@"reviews: %@",[[results objectAtIndex:1] objectForKey:@"review_count"]);
                 NSLog(@"url: %@",[[results objectAtIndex:1] objectForKey:@"url"]);

                 // business3
                 NSLog(@"name: %@",[[results objectAtIndex:2] objectForKey:@"name"]);
                 NSLog(@"rating: %@",[[results objectAtIndex:2] objectForKey:@"rating"]);
                 NSLog(@"address: %@",[[[[results objectAtIndex:2] objectForKey:@"location"] objectForKey:@"address"] objectAtIndex:0]);
                 NSLog(@"reviews: %@",[[results objectAtIndex:2] objectForKey:@"review_count"]);
                 NSLog(@"url: %@",[[results objectAtIndex:2] objectForKey:@"url"]);

                 // business4
                 NSLog(@"name: %@",[[results objectAtIndex:3] objectForKey:@"name"]);
                 NSLog(@"rating: %@",[[results objectAtIndex:3] objectForKey:@"rating"]);
                 NSLog(@"address: %@",[[[[results objectAtIndex:3] objectForKey:@"location"] objectForKey:@"address"] objectAtIndex:0]);
                 NSLog(@"reviews: %@",[[results objectAtIndex:3] objectForKey:@"review_count"]);
                 NSLog(@"url: %@",[[results objectAtIndex:3] objectForKey:@"url"]);

                 // business5
                 NSLog(@"name: %@",[[results objectAtIndex:4] objectForKey:@"name"]);
                 NSLog(@"rating: %@",[[results objectAtIndex:4] objectForKey:@"rating"]);
                 NSLog(@"address: %@",[[[[results objectAtIndex:4] objectForKey:@"location"] objectForKey:@"address"] objectAtIndex:0]);
                 NSLog(@"reviews: %@",[[results objectAtIndex:4] objectForKey:@"review_count"]);
                 NSLog(@"url: %@",[[results objectAtIndex:4] objectForKey:@"url"]);

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
