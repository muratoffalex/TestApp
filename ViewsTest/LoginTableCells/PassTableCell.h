//
//  PassTableCell.h
//  ViewsTest
//
//  Created by admin on 24.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "RowHeight.h"

@interface PassTableCell : UITableViewCell <RowHeight>

@property (nonatomic) UITextField *passTextField;

@end
