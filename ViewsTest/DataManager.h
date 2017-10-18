//
//  DataManager.h
//  ViewsTest
//
//  Created by admin on 17.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (DataManager *)sharedInstance;

- (NSData*) loadImage:(NSInteger) ID;

- (NSArray*) loadData;

@end
