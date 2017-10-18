//
//  Employee.m
//  ViewsTest
//
//  Created by admin on 09.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "Employee.h"

@implementation Employee

- (NSMutableArray*) parseEmployee : (NSDictionary*) Emplo : (NSInteger) parentID {
    
    NSMutableArray* employees = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dic in Emplo) {
        Employee* emp = [[Employee alloc] init];
        
        for (NSString* key in dic) {
            if ([emp respondsToSelector:NSSelectorFromString(key)]) {
                [emp setValue:[dic valueForKey:key] forKey:key];
            }
            [emp setParentID:parentID];
        }
        
        //NSLog(@"ID = %ld, Name = %@, Title = %@, Email = %@, Phone = %@", emp.ID, emp.Name, emp.Title, emp.Email, emp.Phone); // das
        
        [employees addObject:emp];
    }
    
    return employees;
}

@end
