//
//  EntryTableCell.m
//  ViewsTest
//
//  Created by admin on 24.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "EntryTableCell.h"

@implementation EntryTableCell

@synthesize rowHeight;

- (id)init
{
    self = [super init];
    if (self) {
        
        self.rowHeight = 70;
        
        [self setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.8]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _entryButton = [UIButton new];
        [_entryButton setTitle:@"Войти" forState:UIControlStateNormal];
        [_entryButton setBackgroundColor:[UIColor lightGrayColor]];
        [_entryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview:_entryButton];
        
        [_entryButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
            make.trailingMargin.equalTo(self.mas_trailing).offset(-30);
            make.left.equalTo(@25);
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
