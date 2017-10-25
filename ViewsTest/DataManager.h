//
//  DataManager.h
//  ViewsTest
//
//  Created by admin on 17.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataManager : NSObject

+ (DataManager *)sharedInstance;

@property (copy, nonatomic) NSString* login;
@property (copy, nonatomic) NSString* password;
@property (assign, nonatomic) BOOL status;
@property (assign, nonatomic) BOOL access;

- (NSData*) loadImage:(NSInteger) ID;

- (void) saveUserData:(BOOL) status;
- (void) loadUserData;

- (void) getLoginData : (NSString*) login : (NSString*) password;

- (void) showPopUp: (NSString*) title : (NSString*) message : (NSString*) actionTitle : (UIViewController*) view;
- (void) printCannotLoad:(UIViewController*) view;

@end
