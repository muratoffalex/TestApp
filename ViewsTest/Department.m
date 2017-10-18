//
//  Department.m
//  ViewsTest
//
//  Created by admin on 09.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "Department.h"

@implementation Department

- (Department*) parseData:(NSDictionary*) dic {
    
    Department* dep = [[Department alloc] init];
    
    [dep setValue: [dic valueForKey:@"ID"] forKey:@"ID"];
    [dep setName: [dic valueForKey:@"Name"]];
    
    Employee* emp = [[Employee alloc] init];
    
    //NSLog(@"ID = %ld, Name = %@", dep.ID, dep.Name);
    
    if ([dic valueForKey:@"Departments"]) {
        NSArray* departments = [dic valueForKey:@"Departments"];
        dep.Departments = [dep parseChild:departments:dep.ID];
    }
    
    if ([dic valueForKey:@"Employees"]) {
        NSDictionary* employees = [dic valueForKey:@"Employees"];
        dep.Employees = [emp parseEmployee:employees:dep.ID];
    }
    
    return dep;
}

- (NSMutableArray*) parseChild:(NSArray*) departmentsDic : (NSInteger) parentID {
    
    NSMutableArray* departments = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dic in departmentsDic) {
        Department* dep = [[Department alloc] init];
        Employee* emp = [[Employee alloc] init];
        
        
        [dep setValue: [dic valueForKey:@"ID"] forKey:@"ID"];
        [dep setName: [dic valueForKey:@"Name"]];
        
        //NSLog(@"ID = %ld, Name = %@", dep.ID, dep.Name);
        
        if ([dic valueForKey:@"Departments"]) {
            dep.Departments = [self parseChild:[dic valueForKey:@"Departments"]:dep.ID];
        }
        
        if ([dic valueForKey:@"Employees"]) {
            dep.Employees = [emp parseEmployee:[dic valueForKey:@"Employees"]:dep.ID];
        }
        
        [departments addObject:dep];
    }
    
    
    
    return departments;
}

@end
