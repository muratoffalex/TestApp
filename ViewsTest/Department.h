//
//  Department.h
//  ViewsTest
//
//  Created by admin on 09.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Employee.h"

@interface Department : NSObject

@property (assign, nonatomic) NSInteger ID;
@property (strong, nonatomic) NSString* Name;
@property (strong, nonatomic) NSMutableArray* Departments;
@property (strong, nonatomic) NSMutableArray* Employees;

- (NSMutableArray*) parseChild:(NSArray*) dic : (NSInteger) parentID;
- (Department*) parseData:(NSDictionary*) dic;

@end
