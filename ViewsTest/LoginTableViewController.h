//
//  LoginTableViewController.h
//  ViewsTest
//
//  Created by admin on 17.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassTableCell.h"
#import "EntryTableCell.h"
#import "RememberTableCell.h"
#import "LoginTableCell.h"
#import "Masonry.h"

@interface LoginTableViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic) LoginTableCell* loginCell;
@property (nonatomic) EntryTableCell* entryCell;
@property (nonatomic) PassTableCell* passCell;
@property (nonatomic) RememberTableCell* rememberCell;

@property (assign, nonatomic) BOOL status;

@end
