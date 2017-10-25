//
//  ImageEmployeeTableCell.m
//  ViewsTest
//
//  Created by admin on 24.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "ImageEmployeeTableCell.h"

@implementation ImageEmployeeTableCell

@synthesize rowHeight;

- (id)init
{
    self = [super init];
    if (self) {
        
        rowHeight = 197;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _image = [UIImageView new];
        _image.layer.cornerRadius = 92.5;
        _image.clipsToBounds = YES;
        [_image sizeToFit];
        
        [self addSubview:_image];
        
        [_image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.centerY.equalTo(@0);
            make.width.equalTo(@185);
            make.height.equalTo(@185);
        }];
        
        _photoDownloadProgress = [UIProgressView new];
        _photoDownloadProgress.progress = 0.f;
        [_photoDownloadProgress sizeToFit];
        
        [self addSubview:_photoDownloadProgress];
        
        [_photoDownloadProgress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.centerY.equalTo(@0);
            make.width.equalTo(@150);
            make.height.equalTo(@3);
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
