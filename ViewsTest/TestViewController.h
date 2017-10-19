//
//  TestViewController.h
//  ViewsTest
//
//  Created by admin on 05.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department.h"

@interface TestViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString* login;
@property (strong, nonatomic) NSString* password;
@property (strong, nonatomic) Department* path;
@property (strong, nonatomic) NSMutableArray* tableData;
@property (strong, nonatomic) NSString* tabName;

@property (retain, nonatomic) TestViewController* root;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
