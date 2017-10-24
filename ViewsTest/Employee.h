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
@property (copy, nonatomic) NSString* Name;
@property (copy, nonatomic) NSString* Title;
@property (copy, nonatomic) NSString* Email;
@property (copy, nonatomic) NSString* Phone;

- (NSMutableArray*) parseEmployee : (NSObject*) Employee;

@end
