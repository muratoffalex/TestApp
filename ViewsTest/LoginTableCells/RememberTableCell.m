//
//  RememberTableCell.m
//  ViewsTest
//
//  Created by admin on 24.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "RememberTableCell.h"

@implementation RememberTableCell

@synthesize rowHeight;

- (id)init
{
    self = [super init];
    if (self) {
        
        self.rowHeight = 50;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView* image = [UIImageView new];
        
        [image setImage:[UIImage imageNamed:@"key"]];
        [image sizeToFit];
        
        [self addSubview:image];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@24);
            make.height.equalTo(@24);
            make.left.equalTo(@15);
            make.top.equalTo(@13);
        }];
        
        UILabel* label = [UILabel new];
        label.text = @"Запомнить";
        [label sizeToFit];
        
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@47);
            make.top.equalTo(@15);
        }];
        
        _rememberSwitch = [UISwitch new];
        [_rememberSwitch sizeToFit];
        [_rememberSwitch setOn:YES];
        
        [self addSubview:_rememberSwitch];
        //UIEdgeInsets padding = UIEdgeInsetsMake(10, 0, 0, 0);
        
        [_rememberSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailingMargin.equalTo(self.mas_trailing).offset(-23);
            make.top.equalTo(@10);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
