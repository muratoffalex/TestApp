//
//  EmployeeTableViewController.m
//  ViewsTest
//
//  Created by admin on 16.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "EmployeeTableViewController.h"
#import "DataManager.h"
#import "InfoEmployeeTableCell.h"
#import "ImageEmployeeTableCell.h"

@interface EmployeeTableViewController ()

@end

@implementation EmployeeTableViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView* tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBack"]];
    [tempImageView setFrame: self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    
    [self.tableView registerClass: [InfoEmployeeTableCell class] forCellReuseIdentifier:@"TableCell"];
    
    //self.navigationItem.title = self.Name;
    self.navigationItem.title = @"Сотрудник";
    
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
    
}

#pragma mark - Download Images

- (void) imageDownload {
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"https://contact.taxsee.com/Contacts.svc/GetWPhoto?login=%@&password=%@&id=%ld", [DataManager sharedInstance].login, [DataManager sharedInstance].password, self.ID]];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
    [downloadTask resume];
}

#pragma mark - NSURLSession

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableCell";
    InfoEmployeeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[InfoEmployeeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            // TODO: Image for employee info
//            ImageEmployeeTableCell *imageCell = [[ImageEmployeeTableCell alloc] init];
//
//            cell = imageCell;
            
            break;
        case 1:
            cell.title.text = @"ID";
            cell.descrip.text = [NSString stringWithFormat:@"%ld", _ID];
            break;
        case 2:
            cell.title.text = @"Имя";
            cell.descrip.text = [NSString stringWithFormat:@"%@", _Name];
            break;
        case 3:
            cell.title.text = @"Должность";
            cell.descrip.text = [NSString stringWithFormat:@"%@", _Title];
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void) back:(id) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headerTitle;
    if (section==0) {
        headerTitle = @"Информация";
    }
    return headerTitle;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return CGFLOAT_MIN;
    return tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        tableView.rowHeight = 197;
    } else if (indexPath.row == 3) {
        tableView.rowHeight = 80;
    } else {
        tableView.rowHeight = 60;
    }
    
    return tableView.rowHeight;
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
