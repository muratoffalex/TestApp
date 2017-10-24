//
//  InfoEmployeeTableCell.m
//  ViewsTest
//
//  Created by admin on 24.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "InfoEmployeeTableCell.h"

@implementation InfoEmployeeTableCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _title = [UILabel new];
        [_title sizeToFit];
        
        [_title setFont:[UIFont boldSystemFontOfSize:17]];
        
        [self addSubview:_title];
        
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@8);
            make.left.equalTo(@19);
        }];
        
        _descrip = [UILabel new];
        [_descrip sizeToFit];
        [_descrip setNumberOfLines:0];
        [_descrip setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
        
        [self addSubview:_descrip];
        
        [_descrip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@30);
            make.left.equalTo(@19);
            make.right.equalTo(@0);
            //make.trailingMargin.equalTo(self.mas_trailing).offset(0);
        }];
    }
    return self;
}

//- (id)init
//{
//    self = [super init];
//    if (self) {
//        _title = [UILabel new];
//        [_title sizeToFit];
//
//        [self addSubview:_title];
//
//        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@8);
//            make.left.equalTo(@19);
//        }];
//
//        _descrip = [UILabel new];
//        [_descrip sizeToFit];
//
//        [self addSubview:_descrip];
//
//        [_descrip mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@30);
//            make.left.equalTo(@19);
//        }];
//
//    }
//    return self;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
