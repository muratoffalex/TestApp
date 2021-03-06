//
//  TestViewController.m
//  ViewsTest
//
//  Created by admin on 05.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "TestViewController.h"
#import "Department.h"
#import "Employee.h"
#import "EmployeeTableViewController.h"
#import "DataManager.h"
#import "Masonry.h"
#import "AppDelegate.h"

@interface TestViewController ()

@property (strong, nonatomic) NSMutableArray* currentArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectNull
                                              style:UITableViewStyleGrouped];
    [_tableView sizeToFit];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@-35);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    if ([self.navigationController.viewControllers count] <= 2) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadData:nil];
        });
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIImageView* tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBack"]];
    [tempImageView setFrame: self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    if ([self.navigationController.viewControllers count] <= 2) {
        self.navigationItem.title = @"Отделения";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Выход"
                                                                                 style:UIBarButtonItemStyleDone
                                                                                target:self
                                                                                action:@selector(logout:)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Обновить"
                                                                                  style:UIBarButtonItemStyleDone
                                                                                 target:self
                                                                                 action:@selector(loadData:)];
    } else {
        self.navigationItem.title = self.tabName;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"В начало"
                                                                                  style:UIBarButtonItemStyleDone
                                                                                 target:self
                                                                                 action:@selector(returnToRoot:)];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[self.currentArray objectAtIndex:indexPath.row] isKindOfClass:[Employee class]]) {
        EmployeeTableViewController* evc = [[EmployeeTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        
        Employee* emp = [[Employee alloc] init];
        emp = [self.currentArray objectAtIndex:indexPath.row];
        
        evc.ID = emp.ID;
        evc.Name = emp.Name;
        evc.Title = emp.Title;
        evc.Phone = emp.Phone;
        evc.Email = emp.Email;
        evc.parentName = self.tabName;
        
        [self.navigationController pushViewController:evc animated:YES];
        
    } else if ([[self.currentArray objectAtIndex:indexPath.row] isKindOfClass:[Department class]]) {
        
        TestViewController* vc = [TestViewController new];
        
        Department* dep = [[Department alloc] init];
        dep = [self.currentArray objectAtIndex:indexPath.row];
        vc.tabName = dep.Name;;
        
        if (dep.Departments != NULL) {
            vc.currentArray = dep.Departments;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (dep.Employees != NULL) {
            vc.currentArray = dep.Employees;
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            [[DataManager sharedInstance] showPopUp:@"Оповещение" : @"Отдел пуст" : @"ОК": self];
        }
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if ([[self.currentArray objectAtIndex:indexPath.row] isKindOfClass:[Department class]]) {
        Department* dep = [self.currentArray objectAtIndex:indexPath.row];
        cell.textLabel.text = dep.Name;
        cell.tag = dep.ID;
        cell.imageView.image = [UIImage imageNamed:@"department"];
    } else if ([[self.currentArray objectAtIndex:indexPath.row] isKindOfClass:[Employee class]]) {
        Employee* emp = [self.currentArray objectAtIndex:indexPath.row];
        cell.textLabel.text = emp.Name;
        cell.tag = emp.ID;
        //cell.imageView.image = [UIImage imageWithData:[[DataManager sharedInstance] loadImage:emp.ID]];
        cell.imageView.image = [UIImage imageNamed:@"human"];
    }
    
    return cell;
}

#pragma mark - Receive, parsing data

// загрузка, парсинг json GetAll и вывод в таблицу 0 уровень
- (void) loadData:(id)sender {
    [self.currentArray removeAllObjects];
    [self.tableView reloadData];
    
    NSString* formatURL = [NSString stringWithFormat:@"https://contact.taxsee.com/Contacts.svc/GetAll?login=%@&password=%@",
                           [DataManager sharedInstance].login,
                           [DataManager sharedInstance].password];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:formatURL]];
    [request setHTTPMethod:@"GET"];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
        if (data == nil) {
            [[DataManager sharedInstance] printCannotLoad:self];
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
            
            self.currentArray = departments;
            
            NSMutableArray* newPaths = [NSMutableArray array];
            for (int i = 0; i < [self.currentArray count]; i++) {
                [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView beginUpdates];
                [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView endUpdates];
            });
            
        }
    }];
    
    [task resume];
            
}

#pragma mark - Other functions

- (void) logout:(id)sender {
    NSString *storage = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:storage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.currentArray removeAllObjects];
    [self.tableView reloadData];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) returnToRoot: (id) sender {
    
//    TestViewController *view = [[TestViewController alloc] init];
//
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController pushViewController:view animated:NO];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
