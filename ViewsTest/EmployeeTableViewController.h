//
//  EmployeeTableViewController.h
//  ViewsTest
//
//  Created by admin on 16.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageEmployeeTableCell.h"
#import "DataManager.h"
#import "InfoEmployeeTableCell.h"

@interface EmployeeTableViewController : UITableViewController <NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (assign, nonatomic) NSInteger ID;
@property (copy, nonatomic) NSString* Name;
@property (copy, nonatomic) NSString* Title;
@property (copy, nonatomic) NSString* Email;
@property (copy, nonatomic) NSString* Phone;
@property (copy, nonatomic) NSString* parentName;

@property (assign, nonatomic) NSInteger countRow;

@property (nonatomic) NSMutableData* imageData;
@property (nonatomic) UIImage* downloadedImage;

@property (nonatomic) ImageEmployeeTableCell *cellImage;

@end
