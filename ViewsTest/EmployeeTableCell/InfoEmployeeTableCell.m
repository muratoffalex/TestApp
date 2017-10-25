//
//  InfoEmployeeTableCell.m
//  ViewsTest
//
//  Created by admin on 24.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "InfoEmployeeTableCell.h"

@implementation InfoEmployeeTableCell

@synthesize actionLabel;
@synthesize rowHeight;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        rowHeight = 60;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
        }];
        
        actionLabel = [UILabel new];
        actionLabel.hidden = YES;
        
        [actionLabel setFont:[UIFont fontWithName:@"System-Light" size:15]];
        [actionLabel setTextColor:[UIColor lightGrayColor]];
        
        [actionLabel sizeToFit];
        
        [self addSubview:actionLabel];
        
        [actionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@19);
            make.trailingMargin.equalTo(self.mas_trailing).offset(-20);
        }];
        
    }
    return self;
}

- (void) setLabels: (NSString*) title : (NSString*) descrip : (NSString*) actionLabel {
    self.title.text = title;
    self.descrip.text = descrip;
    
    if ([title isEqualToString:@"Должность"]) {
        [self.descrip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
        }];
    }
    
    if ((actionLabel != nil && actionLabel != NULL) && ![self.descrip.text isEqualToString:@"Отсутствует"]) {
        self.actionLabel.text = actionLabel;
        self.actionLabel.hidden = NO;
    }
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
