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

//@property (weak, nonatomic) IBOutlet UITextField *loginInput;
//@property (weak, nonatomic) IBOutlet UITextField *passInput;
//@property (weak, nonatomic) IBOutlet UIButton *loginButton;
//@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;

@property (assign, nonatomic) BOOL status;


//- (IBAction)loginButtonTapped:(UIButton *)sender;


@end
