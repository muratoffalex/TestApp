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
{
    NSArray *arrayCells;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView* tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBack"]];
    [tempImageView setFrame: self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    
    self.navigationItem.title = @"Сотрудник";
    
    if (self.Email == NULL || self.Email == nil) {
        self.Email = @"Отсутствует";
    }
    
    if (self.Phone == NULL || self.Phone == nil) {
        self.Phone = @"Отсутствует";
    }
    
    NSString *ID = [NSString stringWithFormat:@"%ld", self.ID];
    
    _cellImage = [[ImageEmployeeTableCell alloc] init];
    
    InfoEmployeeTableCell *cellID = [[InfoEmployeeTableCell alloc] init];
    [cellID setLabels: @"ID" : ID : nil];
    
    InfoEmployeeTableCell *cellName = [[InfoEmployeeTableCell alloc] init];
    [cellName setLabels: @"Имя" : self.Name : nil];
    
    InfoEmployeeTableCell *cellTitle = [[InfoEmployeeTableCell alloc] init];
    [cellTitle setLabels: @"Должность" : self.Title : nil];
    
    InfoEmployeeTableCell *cellEmail = [[InfoEmployeeTableCell alloc] init];
    [cellEmail setLabels: @"Email" : self.Email : @"Написать"];
    
    InfoEmployeeTableCell *cellPhone = [[InfoEmployeeTableCell alloc] init];
    [cellPhone setLabels: @"Телефон" : self.Phone : @"Позвонить"];
    
    arrayCells = @[_cellImage, cellID, cellName, cellTitle, cellEmail, cellPhone];
    
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
        [_cellImage.photoDownloadProgress setHidden:YES];
        [self.cellImage.image setImage:[UIImage imageWithData:data]];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    float progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_cellImage.photoDownloadProgress setProgress:progress];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrayCells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell = [arrayCells objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) back:(id) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 4:
            if (![self.Email  isEqual: @"Отсутствует"]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", self.Email]] options:@{} completionHandler:^(BOOL success) {
                    if (!success) {
                        NSLog(@"Error");
                    }}];
            }
            break;
        case 5:
            if (![self.Phone  isEqual: @"Отсутствует"]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", self.Phone]] options:@{} completionHandler:^(BOOL success) {
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
    
    NSInteger rowHeight;
    
    if (indexPath.row == 3) {
        rowHeight = 80;
    } else {
        rowHeight = [[arrayCells objectAtIndex:indexPath.row] rowHeight];
    }
    
    return rowHeight;
}

@end
