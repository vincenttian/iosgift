//
//  MainViewController.m
//  gift
//
//  Created by Tian, Vincent on 8/8/14.
//  Copyright (c) 2014 vincenttian. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // music stuff
    NSString *path = [[NSBundle mainBundle]pathForResource:@"bettertogether" ofType:@"mp3"];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    audioPlayer.numberOfLoops = -1;
    if (audioPlayer == nil) {
        NSLog([error description]);
    } else {
        [audioPlayer play];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
