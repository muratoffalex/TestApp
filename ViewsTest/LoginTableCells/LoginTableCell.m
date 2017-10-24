//
//  LoginTableCell.m
//  ViewsTest
//
//  Created by admin on 24.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "LoginTableCell.h"

@implementation LoginTableCell

- (id)init
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        
        _loginTextField = [UITextField new];
        _loginTextField.placeholder = @"Логин";
        [_loginTextField setReturnKeyType:UIReturnKeyNext];
        [_loginTextField setTextContentType:UITextContentTypeUsername];
        
        [self addSubview:_loginTextField];
        
        [_loginTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.trailingMargin.equalTo(self.mas_trailing).offset(-20);
            make.left.equalTo(@20);
            make.top.equalTo(@8);
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
