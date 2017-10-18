//
//  EmployeeTableViewController.h
//  ViewsTest
//
//  Created by admin on 16.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeeTableViewController : UITableViewController <NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (assign, nonatomic) NSInteger ID;
@property (strong, nonatomic) NSString* Name;
@property (strong, nonatomic) NSString* Title;
@property (strong, nonatomic) NSString* Email;
@property (strong, nonatomic) NSString* Phone;
@property (strong, nonatomic) NSString* parentName;

@property (assign, nonatomic) NSInteger countRow;

@property (retain, nonatomic) NSMutableData* imageData;
@property (strong, nonatomic) UIImage* downloadedImage;
@property (weak, nonatomic) IBOutlet UIProgressView *photoDownloadProgress;


@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *emailCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *phoneCell;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *writeToEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *callLabel;

@end
