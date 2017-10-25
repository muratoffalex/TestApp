//
//  RowHeight.h
//  ViewsTest
//
//  Created by admin on 25.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RowHeight <NSObject>

@optional

@property (nonatomic) UILabel *actionLabel;

- (void) setLabels: (NSString*) title : (NSString*) descrip : (NSString*) actionLabel;

@required

@property (assign, nonatomic) CGFloat rowHeight;

@end
