//
//  AppDelegate.h
//  ViewsTest
//
//  Created by admin on 05.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"
#import "DataManager.h"
#import "MainNavigationController.h"
#import "LoginTableViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) MainNavigationController *mainNav;

@end

