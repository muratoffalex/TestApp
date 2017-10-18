//
//  EmployeeTableViewController.m
//  ViewsTest
//
//  Created by admin on 16.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "EmployeeTableViewController.h"

@interface EmployeeTableViewController ()

@end

@implementation EmployeeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.Name;
    
    self.navigationController.navigationBar.prefersLargeTitles = TRUE;
    
    _idLabel.text = [NSString stringWithFormat:@"%ld", self.ID];
    _nameLabel.text = self.Name;
    _titleLabel.text = self.Title;
    
    
    self.countRow = 6;
    if (self.Email == NULL) {
        _emailLabel.text = @"Отсутствует";
        _writeToEmailLabel.hidden = YES;
    } else {
        _emailLabel.text = self.Email;
    }
    
    if (self.Phone == NULL) {
        _phoneLabel.text = @"Отсутствует";
        _callLabel.hidden = YES;
    } else {
        _phoneLabel.text = self.Phone;
    }
    
    _photoImageView.layer.cornerRadius = _photoImageView.frame.size.width / 2;
    _photoImageView.clipsToBounds = YES;
    [self imageDownload];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) imageDownload {
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://contact.taxsee.com/Contacts.svc/GetWPhoto?login=%@&password=%@&id=%ld", [[NSUserDefaults standardUserDefaults] stringForKey:@"login"], [[NSUserDefaults standardUserDefaults] stringForKey:@"password"], self.ID]];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
    [downloadTask resume];
}

- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData* data = [NSData dataWithContentsOfURL:location];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.photoDownloadProgress setHidden:YES];
        [self.photoImageView setImage:[UIImage imageWithData:data]];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    float progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.photoDownloadProgress setProgress:progress];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.countRow;
}

- (void) back:(id) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 3:
            
            break;
        case 5:
            if (![_phoneLabel.text  isEqual: @"Отсутствует"]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", _phoneLabel.text]] options:@{} completionHandler:^(BOOL success) {
                    if (!success) {
                        NSLog(@"Error");
                    }}];
            }
            break;
        case 4:
            if (![_emailLabel.text  isEqual: @"Отсутствует"]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", _emailLabel.text]] options:@{} completionHandler:^(BOOL success) {
                    if (!success) {
                        NSLog(@"Error");
                    }}];
            }
            break;
        default:
            break;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return CGFLOAT_MIN;
    return tableView.sectionHeaderHeight;
}
//
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
//(NSInteger)section{
//    NSString *headerTitle;
//    if (section==0) {
//        headerTitle = @"Информация";
//    }
//    return headerTitle;
//}

@end
