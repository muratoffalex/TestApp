//
//  Employee.h
//  ViewsTest
//
//  Created by admin on 09.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject

@property (assign, nonatomic) NSInteger ID;
@property (strong, nonatomic) NSString* Name;
@property (strong, nonatomic) NSString* Title;
@property (strong, nonatomic) NSString* Email;
@property (strong, nonatomic) NSString* Phone;
@property (assign, nonatomic) NSInteger ParentID;

- (NSMutableArray*) parseEmployee : (NSObject*) Employee : (NSInteger) ParentID;

@end
