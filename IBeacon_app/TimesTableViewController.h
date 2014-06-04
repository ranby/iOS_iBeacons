//
//  TimesTableViewController.h
//  IBeacon_app
//
//  Created by eran on 6/3/14.
//  Copyright (c) 2014 Dewire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimesTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* startTimes;
@property (strong, nonatomic) NSArray* stopTimes;

@end
