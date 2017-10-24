//
//  ImageEmployeeTableCell.m
//  ViewsTest
//
//  Created by admin on 24.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "ImageEmployeeTableCell.h"

@implementation ImageEmployeeTableCell

- (id)init
{
    self = [super init];
    if (self) {
        _image = [UIImageView new];
        [_image sizeToFit];
        
        [self addSubview:_image];
        
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.centerY.equalTo(@0);
            make.width.equalTo(@185);
            make.height.equalTo(@185);
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
