//
//  ViewController.m
//  LocalNotificationSchedule
//
//  Created by Stronger Shen on 13/10/22.
//  Copyright (c) 2013年 MobileIT. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *eventText;
@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation ViewController

#pragma mark - Refresh TableView

- (void)refreshTableView:(NSNotification *)notification
{
    [self.listTableView reloadData];
}

#pragma mark - View

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    float currSysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
//    float statusBar = 0.0;
//    if (currSysVer >= 7.0) {
//        statusBar = 20;
//    }
//    CGRect rectScreen = [[UIScreen mainScreen] bounds];
//    CGSize sizeScreen = rectScreen.size;
//    
//    
    
    
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshTableView:)
                                                 name:@"RefreshTableViewDatas"
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSArray *notifs =
//    [[UIApplication sharedApplication] scheduledLocalNotifications];
    return [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
//    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    NSArray *notifs = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *notif = [notifs objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"(%d) %@", notif.applicationIconBadgeNumber, notif.alertBody];
    
    //取出時間，轉換時區，顯示在 cell.detailTextLabel
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    cell.detailTextLabel.text = [dateFormat stringFromDate: notif.fireDate];
    
    return cell;
}


#pragma mark - Added methods

- (IBAction)scheduleAction:(id)sender {
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    
    localNotif.fireDate = [self.datePicker date];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    localNotif.alertBody = self.eventText.text;
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
    //重新安排 applicationIconBadgeNumber
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate ReOrderApplicationIconBadgeNumber];
    
    [self.listTableView reloadData];
    [self.eventText resignFirstResponder];
}


- (IBAction)textDoneAction:(id)sender {
//    [sender resignFirstResponder];
}





@end
