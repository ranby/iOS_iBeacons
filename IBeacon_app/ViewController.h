//
//  ViewController.h
//  IBeacon_app
//
//  Created by eran on 6/3/14.
//  Copyright (c) 2014 Dewire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *beaconLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;

@end
