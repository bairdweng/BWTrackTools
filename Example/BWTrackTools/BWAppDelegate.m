//
//  BWAppDelegate.m
//  BWTrackTools
//
//  Created by baird weng on 01/16/2020.
//  Copyright (c) 2020 baird weng. All rights reserved.
//

#import "BWAppDelegate.h"
#import <BWTrackToolsHeader.h>
@implementation BWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[BWTraceManager share] setUpWithConfigJsonFile:@"trackConfig"
        withPageEvent:^(BWTrackPageEventType type, NSString *pageName, NSDictionary *params) {
            NSLog(@"页面名称:%@", pageName);
            NSLog(@"页面状态:%@", type == BWTrackPageEventTypeStart ? @"开始" : @"结束");
            NSLog(@"透传参数:%@", params);
        }
        withEvent:^(NSString *className, NSString *eventName, NSArray *arguments, NSDictionary *params) {
            NSLog(@"hook类名:%@", className);
            NSLog(@"事件名称:%@", eventName);
            NSLog(@"参数列表:%@", arguments);
            NSLog(@"透传参数:%@", params);
        }];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
