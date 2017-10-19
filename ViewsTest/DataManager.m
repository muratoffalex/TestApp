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

- (NSArray*) loadData {
    NSString* formatURL = [NSString stringWithFormat:@"https://contact.taxsee.com/Contacts.svc/GetAll?login=%@&password=%@",
                           [[NSUserDefaults standardUserDefaults] stringForKey:@"login"],
                           [[NSUserDefaults standardUserDefaults] stringForKey:@"password"]];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:formatURL]];
    [request setHTTPMethod:@"GET"];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
        if (data == nil) {
            [self printCannotLoad];
        } else {
            
            NSError *error = nil;
            NSDictionary* parsedJson = [NSJSONSerialization
                                        JSONObjectWithData:data
                                        options:0
                                        error:&error];
            
            NSMutableArray* departments = [[NSMutableArray alloc] init];
            
            NSArray* departmentsInfo = [parsedJson valueForKeyPath:@"Departments"];
            
            for (NSDictionary* departmentsDic in departmentsInfo) {
                Department* department = [[Department alloc] init];
                
                [departments addObject:[department parseData:departmentsDic]];
            }
            
            self.currentArray = [NSArray arrayWithArray:departments].mutableCopy;
        }
    }];
    
    [task resume];
    return self.currentArray;
}

- (void) printCannotLoad {
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"ERROR");
    });
}

- (void) manageUserData:(BOOL) status {
    
    // здесь будут обрабатываться данные из NSUserDefaults
    
}

@end
