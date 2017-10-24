//
//  AppDelegate.m
//  ViewsTest
//
//  Created by admin on 05.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"
#import "DataManager.h"
#import "MainNavigationController.h"
#import "LoginTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //[[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    [[DataManager sharedInstance] loadUserData];
    
    LoginTableViewController* mainView = [[LoginTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    MainNavigationController *mainNav = [[MainNavigationController alloc] initWithRootViewController:mainView];
    
    //BOOL logined = [DataManager sharedInstance].status ? 1 : 0;
//    if (logined) {
//        TestViewController* testView = [[TestViewController alloc] init];
//        mainNav = [[MainNavigationController alloc] initWithRootViewController:testView];
//    } else {
//        LoginTableViewController* mainView = [[LoginTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
//        mainNav = [[MainNavigationController alloc] initWithRootViewController:mainView];
//    }
    
    self.window.rootViewController = mainNav;
    
//    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIStoryboard* storyboardLogin = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
////    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
////    NSInteger status = [defaults integerForKey:@"status"];
    
//    BOOL logined = [DataManager sharedInstance].status ? 1 : 0;
//
//    if (!logined) {
//        self.window.rootViewController = [storyboardLogin instantiateViewControllerWithIdentifier:@"loginNav"];
//    } else {
//        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"mainNav"];
//    }
//
//    [self.window makeKeyAndVisible];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSInteger status = [defaults integerForKey:@"status"];
//
//    if (status == 1) {
//        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"mainNav"];
//    } else if (status == 0) {
//        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"mainNav"];
//    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
