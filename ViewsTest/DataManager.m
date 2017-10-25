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

#pragma mark - Working with data

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

#pragma mark - Get and deserialization data

- (void) getLoginData : (NSString*) login : (NSString*) password {
    
    NSString* formatURL = [NSString stringWithFormat:@"https://contact.taxsee.com/Contacts.svc/Hello?login=%@&password=%@",
                           login,
                           password];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:formatURL]];
    [request setHTTPMethod:@"GET"];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
        if (data == nil) {
            //[self printCannotLoad];
            NSLog(@"kek");
        } else {
           [self handleData:data];
        }
    }];
    
    [task resume];
}

- (void) handleData: (NSData*) data {
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:data
                 options:0
                 error:&error];
    
    if(error) {
        NSLog(@"Error NSJSONSerilazation");
        return;
    }
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSString* success = [object valueForKey:@"Success"];
        self.access = [[NSString stringWithFormat:@"%@", success] isEqualToString:@"1"] ? YES : NO;
    }
}

#pragma mark - Other helpful functions

- (void) showPopUp: (NSString*) title : (NSString*) message : (NSString*) actionTitle : (UIViewController*) view {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:actionTitle
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    [alertController addAction:actionCancel];
    [view presentViewController:alertController animated:YES completion:nil];
}

- (void) printCannotLoad:(UIViewController*) view {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [[DataManager sharedInstance] showPopUp:@"Ошибка" : @"Ошибка при выполнении запроса. Попробуйте снова." : @"ОК": view];
    });
}


@end
