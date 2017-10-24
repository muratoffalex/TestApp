//
//  DataManager.m
//  ViewsTest
//
//  Created by admin on 17.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "DataManager.h"
#import "Department.h"

@interface DataManager ()

@property (strong, nonatomic) NSArray* currentArray;
@property (strong, nonatomic) NSData* imageData;

@end

@implementation DataManager

+ (DataManager *)sharedInstance {
    static DataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
    });
    return sharedInstance;
}

- (NSData*) loadImage:(NSInteger) ID {
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://contact.taxsee.com/Contacts.svc/GetWPhoto?login=%@&password=%@&id=%ld", [[NSUserDefaults standardUserDefaults] stringForKey:@"login"], [[NSUserDefaults standardUserDefaults] stringForKey:@"password"], ID]];
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        self.imageData = [NSData dataWithContentsOfURL:location];
     }];
    
    [downloadPhotoTask resume];
    
    return self.imageData;
}
- (void) saveUserData:(BOOL) status {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (status) {
        [defaults setBool:YES forKey:@"status"];
        [defaults setValue:self.login forKey:@"login"];
        [defaults setValue:self.password forKey:@"password"];
        [defaults synchronize];
    }
}

- (void) loadUserData {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults boolForKey:@"status"]) {
            self.status = [defaults boolForKey:@"status"];
            self.login = [defaults stringForKey:@"login"];
            self.password = [defaults stringForKey:@"password"];
        }
}

@end
