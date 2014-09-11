//
//  LASAppDelegate.m
//  Alcolater
//
//  Created by Lisa Accardi on 9/6/14.
//  Copyright (c) 2014 com.lemonappstand. All rights reserved.
//

#import "LASAppDelegate.h"
#import "LASViewController.h"
#import "LASWhiskeyViewController.h"

@implementation LASAppDelegate 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    
    // Override point for customization after application launch.

    LASViewController *wineVC = [[LASViewController alloc] init];
    LASWhiskeyViewController *whiskeyVC = [[LASWhiskeyViewController alloc] init];
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.viewControllers = @[wineVC, whiskeyVC];
    tabBarVC.delegate = self;
    self.window.rootViewController = tabBarVC;
    
 
   
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[LASWhiskeyViewController class]]) {
        NSLog(@"New View Controller Selected:Whiskey");
    } else {
    NSLog(@"New View Controller Selected:Wine");
}
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
