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

@property(strong, nonatomic) IBOutlet UILabel *name1;
@property(strong, nonatomic) IBOutlet UILabel *category1;
@property(strong, nonatomic) IBOutlet UILabel *rating1;
@property(strong, nonatomic) IBOutlet UILabel *reviews1;
@property(strong, nonatomic) IBOutlet UILabel *address1;
@property(strong, nonatomic) IBOutlet UILabel *url1;

@property(strong, nonatomic) IBOutlet UILabel *name2;
@property(strong, nonatomic) IBOutlet UILabel *category2;
@property(strong, nonatomic) IBOutlet UILabel *rating2;
@property(strong, nonatomic) IBOutlet UILabel *reviews2;
@property(strong, nonatomic) IBOutlet UILabel *address2;
@property(strong, nonatomic) IBOutlet UILabel *url2;

@property(strong, nonatomic) IBOutlet UILabel *name3;
@property(strong, nonatomic) IBOutlet UILabel *category3;
@property(strong, nonatomic) IBOutlet UILabel *rating3;
@property(strong, nonatomic) IBOutlet UILabel *reviews3;
@property(strong, nonatomic) IBOutlet UILabel *address3;
@property(strong, nonatomic) IBOutlet UILabel *url3;

@property(strong, nonatomic) IBOutlet UILabel *name4;
@property(strong, nonatomic) IBOutlet UILabel *category4;
@property(strong, nonatomic) IBOutlet UILabel *rating4;
@property(strong, nonatomic) IBOutlet UILabel *reviews4;
@property(strong, nonatomic) IBOutlet UILabel *address4;
@property(strong, nonatomic) IBOutlet UILabel *url4;

@property(strong, nonatomic) IBOutlet UILabel *name5;
@property(strong, nonatomic) IBOutlet UILabel *category5;
@property(strong, nonatomic) IBOutlet UILabel *rating5;
@property(strong, nonatomic) IBOutlet UILabel *reviews5;
@property(strong, nonatomic) IBOutlet UILabel *address5;
@property(strong, nonatomic) IBOutlet UILabel *url5;

@end

@implementation ActivitySuggestorController

- (void)viewWillAppear:(BOOL)animated {
    
    [Flurry logEvent:@"Went to activity suggestor page"];
    
    // get lat long
    lm = [[CLLocationManager alloc] init];
    lm.delegate = self;
    lm.desiredAccuracy = kCLLocationAccuracyBest;
    lm.distanceFilter = kCLDistanceFilterNone;
    [lm startUpdatingLocation];
    CLLocation *location = [lm location];
    double latdouble = location.coordinate.longitude;
    double londouble = location.coordinate.latitude;
    
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
         NSString *location;
         if (placemark.locality == nil){
             // initiate with sf if nil
             location = @"San Francisco";
         } else {
             location = placemark.locality;
         }
         [APISample queryTopBusinessInfoForTerm:@"restaurant" location:location completionHandler:^(NSDictionary *notNeeded, NSError *results) {
             if (results) {
                 // business1
                 NSString *name1 = [[results objectAtIndex:0] objectForKey:@"name"];
                 NSString *rating1 = [[results objectAtIndex:0] objectForKey:@"rating"];
                 NSString *address1 = @"";
                 @try {
                     address1 = [[[[results objectAtIndex:0] objectForKey:@"location"] objectForKey:@"address"] objectAtIndex:0];
                 }
                 @catch (NSException * e) {
                     address1 = @"No given address";
                 }
                 NSString *reviews1 = [[results objectAtIndex:0] objectForKey:@"review_count"];
                 NSString *url1 = [[results objectAtIndex:0] objectForKey:@"url"];
                 NSString *category1 = [[[[results objectAtIndex:0] objectForKey:@"categories"] objectAtIndex:0] objectAtIndex:0];
                 NSDictionary *business1Dict = [[NSDictionary alloc] initWithObjects:@[name1, rating1, address1, reviews1, url1, category1] forKeys:@[@"name1", @"rating1", @"address1", @"reviews1", @"url1", @"category1"]];
                 
                 // business2
                 NSString *name2 = [[results objectAtIndex:1] objectForKey:@"name"];
                 NSString *rating2 = [[results objectAtIndex:1] objectForKey:@"rating"];
                 NSString *address2 = @"";
                 @try {
                     address2 = [[[[results objectAtIndex:1] objectForKey:@"location"] objectForKey:@"address"] objectAtIndex:0];
                 }
                 @catch (NSException * e) {
                     address2 = @"No given address";
                 }
                 NSString *reviews2 = [[results objectAtIndex:1] objectForKey:@"review_count"];
                 NSString *url2 = [[results objectAtIndex:1] objectForKey:@"url"];
                 NSString *category2 = [[[[results objectAtIndex:1] objectForKey:@"categories"] objectAtIndex:0] objectAtIndex:0];
                 NSDictionary *business2Dict = [[NSDictionary alloc] initWithObjects:@[name2, rating2, address2, reviews2, url2, category2] forKeys:@[@"name2", @"rating2", @"address2", @"reviews2", @"url2", @"category2"]];
                 
                 // business3
                 NSString *name3 = [[results objectAtIndex:2] objectForKey:@"name"];
                 NSString *rating3 = [[results objectAtIndex:2] objectForKey:@"rating"];
                 NSString *address3 = @"";
                 @try {
                     address3 = [[[[results objectAtIndex:2] objectForKey:@"location"] objectForKey:@"address"] objectAtIndex:0];
                 }
                 @catch (NSException * e) {
                     address3 = @"No given address";
                 }
                 NSString *reviews3 = [[results objectAtIndex:2] objectForKey:@"review_count"];
                 NSString *url3 = [[results objectAtIndex:2] objectForKey:@"url"];
                 NSString *category3 = [[[[results objectAtIndex:2] objectForKey:@"categories"] objectAtIndex:0] objectAtIndex:0];
                 NSDictionary *business3Dict = [[NSDictionary alloc] initWithObjects:@[name3, rating3, address3, reviews3, url3, category3] forKeys:@[@"name3", @"rating3", @"address3", @"reviews3", @"url3", @"category3"]];
                 
                 
                 // business4
                 NSString *name4 = [[results objectAtIndex:3] objectForKey:@"name"];
                 NSString *rating4 = [[results objectAtIndex:3] objectForKey:@"rating"];
                 NSString *address4 = @"";
                 @try {
                     address4 = [[[[results objectAtIndex:3] objectForKey:@"location"] objectForKey:@"address"] objectAtIndex:0];
                 }
                 @catch (NSException * e) {
                     address4 = @"No given address";
                 }
                 NSString *reviews4 = [[results objectAtIndex:3] objectForKey:@"review_count"];
                 NSString *url4 = [[results objectAtIndex:3] objectForKey:@"url"];
                 NSString *category4 = [[[[results objectAtIndex:3] objectForKey:@"categories"] objectAtIndex:0] objectAtIndex:0];
                 NSDictionary *business4Dict = [[NSDictionary alloc] initWithObjects:@[name4, rating4, address4, reviews4, url4, category4] forKeys:@[@"name4", @"rating4", @"address4", @"reviews4", @"url4", @"category4"]];
                 
                 
                 // business5
                 NSString *name5 = [[results objectAtIndex:4] objectForKey:@"name"];
                 NSString *rating5 = [[results objectAtIndex:4] objectForKey:@"rating"];
                 NSString *address5 = @"";
                 @try {
                     address5 = [[[[results objectAtIndex:4] objectForKey:@"location"] objectForKey:@"address"] objectAtIndex:0];
                 }
                 @catch (NSException * e) {
                     address5 = @"No given address";
                 }
                 NSString *reviews5 = [[results objectAtIndex:4] objectForKey:@"review_count"];
                 NSString *url5 = [[results objectAtIndex:4] objectForKey:@"url"];
                 NSString *category5 = [[[[results objectAtIndex:4] objectForKey:@"categories"] objectAtIndex:0] objectAtIndex:0];
                 NSDictionary *business5Dict = [[NSDictionary alloc] initWithObjects:@[name5, rating5, address5, reviews5, url5, category5] forKeys:@[@"name5", @"rating5", @"address5", @"reviews5", @"url5", @"category5"]];
                 
                 dispatch_async(dispatch_get_main_queue(), ^(void){
                     //Run UI Updates
                     [self setUIWithBusiness1:business1Dict withBusiness2:business2Dict withBusiness3:business3Dict withBusiness4:business4Dict andBusiness5:business5Dict];
                 });
                 
             } else {
                 NSLog(@"No business was found");
             }
         }];
     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)setUIWithBusiness1:(NSDictionary *)biz1 withBusiness2:(NSDictionary *)biz2 withBusiness3:(NSDictionary *)biz3 withBusiness4:(NSDictionary *)biz4 andBusiness5:(NSDictionary *)biz5 {
    // set business1 info
    self.name1.text = [biz1 objectForKey: @"name1"];
    self.category1.text = [biz1 objectForKey: @"category1"];
    self.rating1.text = [[[biz1 objectForKey: @"rating1"] stringValue] stringByAppendingString:@" stars"];
    self.reviews1.text = [[[biz1 objectForKey: @"reviews1"] stringValue] stringByAppendingString:@" reviews"];
    self.address1.text = [biz1 objectForKey: @"address1"];
    self.url1.text = [biz1 objectForKey: @"url1"];
    
    // set business2 info
    self.name2.text = [biz2 objectForKey: @"name2"];
    self.category2.text = [biz2 objectForKey: @"category2"];
    self.rating2.text = [[[biz2 objectForKey: @"rating2"] stringValue] stringByAppendingString:@" stars"];
    self.reviews2.text = [[[biz2 objectForKey: @"reviews2"] stringValue] stringByAppendingString:@" reviews"];
    self.address2.text = [biz2 objectForKey: @"address2"];
    self.url2.text = [biz2 objectForKey: @"url2"];
    
    // set business1 info
    self.name3.text = [biz3 objectForKey: @"name3"];
    self.category3.text = [biz3 objectForKey: @"category3"];
    self.rating3.text = [[[biz3 objectForKey: @"rating3"] stringValue] stringByAppendingString:@" stars"];
    self.reviews3.text = [[[biz3 objectForKey: @"reviews3"] stringValue] stringByAppendingString:@" reviews"];
    self.address3.text = [biz3 objectForKey: @"address3"];
    self.url3.text = [biz3 objectForKey: @"url3"];
    
    // set business4 info
    self.name4.text = [biz4 objectForKey: @"name4"];
    self.category4.text = [biz4 objectForKey: @"category4"];
    self.rating4.text = [[[biz4 objectForKey: @"rating4"] stringValue] stringByAppendingString:@" stars"];
    self.reviews4.text = [[[biz4 objectForKey: @"reviews4"] stringValue] stringByAppendingString:@" reviews"];
    self.address4.text = [biz4 objectForKey: @"address4"];
    self.url4.text = [biz4 objectForKey: @"url4"];
    
    // set business5 info
    self.name5.text = [biz5 objectForKey: @"name5"];
    self.category5.text = [biz5 objectForKey: @"category5"];
    self.rating5.text = [[[biz5 objectForKey: @"rating5"] stringValue] stringByAppendingString:@" stars"];
    self.reviews5.text = [[[biz5 objectForKey: @"reviews5"] stringValue] stringByAppendingString:@" reviews"];
    self.address5.text = [biz5 objectForKey: @"address5"];
    self.url5.text = [biz5 objectForKey: @"url5"];
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
