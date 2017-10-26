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

@property (nonatomic) NSString *tabName;

@property (nonatomic) UITableView* tableView;

@end
