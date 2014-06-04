//
//  TimesTableViewController.m
//  IBeacon_app
//
//  Created by eran on 6/3/14.
//  Copyright (c) 2014 Dewire. All rights reserved.
//

#import "TimesTableViewController.h"

@interface TimesTableViewController ()

@end

@implementation TimesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadTimes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTimes {
    NSUserDefaults* nsud = [NSUserDefaults standardUserDefaults];
    self.startTimes = [nsud arrayForKey:@"startTimes"];
    self.stopTimes = [nsud arrayForKey:@"stopTimes"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.startTimes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    double interval = [[self.startTimes objectAtIndex:indexPath.row] doubleValue];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM"];
    NSString* dateString = [dateFormatter stringFromDate:date];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString* startTimeString = [dateFormatter stringFromDate:date];
    
    interval = [[self.stopTimes objectAtIndex:indexPath.row] doubleValue];
    date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString* stopTimeString = [dateFormatter stringFromDate:date];
    
    cell.textLabel.text = dateString;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", startTimeString, stopTimeString];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
