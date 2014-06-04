//
//  ViewController.m
//  IBeacon_app
//
//  Created by eran on 6/3/14.
//  Copyright (c) 2014 Dewire. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) CLLocationManager* CLManager;
@property (strong, nonatomic) CLBeaconRegion* beaconRegion;
@property (strong, nonatomic) NSString* UUIDD;
@property (nonatomic) BOOL ranging;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.UUIDD = @"8492E75F-4FD6-469D-B132-043FE94921D8";
    self.ranging = NO;
    self.CLManager = [[CLLocationManager alloc] init];
    self.CLManager.delegate = self;
    
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:self.UUIDD];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"IBeacon-app"];
    
    [self.CLManager startMonitoringForRegion:self.beaconRegion];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//----------CLLocationManagerDelegate methods-------------

- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion*)region
{
    [self saveWorkTimeStart:YES];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion*)region
{
    [self saveWorkTimeStart:NO];

}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    if (state == CLRegionStateInside) {
        [self.CLManager startRangingBeaconsInRegion:self.beaconRegion];
        self.ranging = YES;
        self.beaconLabel.text = @"Beacon found";
    }
    else if (state == CLRegionStateOutside) {
        self.ranging = NO;
        self.beaconLabel.text = @"No beacons found";
        self.rssiLabel.text = @"";
    }
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    
    if ([beacons count] > 0 && self.ranging) {
        CLBeacon* beacon = [beacons firstObject];
        NSLog(@"uuid %@", beacon.proximityUUID.UUIDString);
        NSLog(@"major %@", beacon.major);
        NSLog(@"minor %@", beacon.minor);
        NSLog(@"rssi %ld", (long)beacon.rssi);
        
        NSString* proximityString;
        if(beacon.proximity == CLProximityUnknown)
            proximityString = @"Unknown";
        if(beacon.proximity == CLProximityFar)
            proximityString = @"Far";
        else if(beacon.proximity == CLProximityNear)
            proximityString = @"Near";
        else if(beacon.proximity == CLProximityImmediate)
            proximityString = @"Immediate";
        self.beaconLabel.text = [NSString stringWithFormat:@"Beacon found - %@", proximityString];
        
        self.rssiLabel.text = [NSString stringWithFormat:@"RSSI: %ld", (long)beacon.rssi];
    }
}

- (void)saveWorkTimeStart:(BOOL)start {
    NSString* key;
    if (start) {
        key = @"startTimes";
    } else {
        key = @"stopTimes";
    }
    
    NSDate* now = [[NSDate alloc] init];
    NSTimeInterval seconds = [now timeIntervalSince1970];
    
    NSUserDefaults* nsud = [NSUserDefaults standardUserDefaults];
    NSArray* times = [nsud arrayForKey:key];
    NSMutableArray* timesCopy;
    if (times == nil) {
        timesCopy = [[NSMutableArray alloc]init];
        [timesCopy addObject:[NSString stringWithFormat:@"%f", seconds]];
    }
    else {
        timesCopy = [[NSMutableArray alloc] initWithArray:times copyItems:YES];
        [timesCopy addObject:[NSString stringWithFormat:@"%f", seconds]];
    }
    
    [nsud setObject:timesCopy forKey:key];
    [nsud synchronize];
}

- (void) insertDummyData {
    [self saveWorkTimeStart:YES];
    [self saveWorkTimeStart:NO];
    [self saveWorkTimeStart:YES];
    [self saveWorkTimeStart:NO];
}

@end


