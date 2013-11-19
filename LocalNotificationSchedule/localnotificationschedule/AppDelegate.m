//
//  AppDelegate.m
//  LocalNotificationSchedule
//
//  Created by Stronger Shen on 13/10/22.
//  Copyright (c) 2013年 MobileIT. All rights reserved.
//

//Test in GitHub!

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark - Added methods
// 每執行一次app就reorder一次
- (void)ReOrderApplicationIconBadgeNumber
{
    NSArray *notifs = [[UIApplication sharedApplication] scheduledLocalNotifications];
    int notifIndex = 1;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    for (UILocalNotification *notif in notifs) {
        notif.applicationIconBadgeNumber = notifIndex;
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
        notifIndex++;
    }
}


#pragma mark - Application

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self ReOrderApplicationIconBadgeNumber];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTableViewDatas" object:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    application.applicationIconBadgeNumber = 0;
    
    [self ReOrderApplicationIconBadgeNumber];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTableViewDatas" object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    // App 執行時、使用中
    // App 在背景、沒有使用時，點選 橫幅、提醒
    
    NSLog(@"%@", notification);
    
    application.applicationIconBadgeNumber = 0;
    
    [self ReOrderApplicationIconBadgeNumber];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTableViewDatas" object:nil];
    
}

@end
