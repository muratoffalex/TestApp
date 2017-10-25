//
//  PassTableCell.m
//  ViewsTest
//
//  Created by admin on 24.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "PassTableCell.h"

@implementation PassTableCell

@synthesize rowHeight;

- (id)init
{
    self = [super init];
    if (self) {
        
        self.rowHeight = 60;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _passTextField = [UITextField new];
        _passTextField.placeholder = @"Пароль";
        _passTextField.secureTextEntry = YES;
        [_passTextField setReturnKeyType:UIReturnKeyDone];
        [_passTextField setTextContentType:UITextContentTypePassword];
        
        [self addSubview:_passTextField];
        
        [_passTextField mas_makeConstraints:^(MASConstraintMaker *make) {
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
