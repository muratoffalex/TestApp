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

@interface TestViewController ()

@property (strong, nonatomic) NSMutableArray* data;
@property (strong, nonatomic) NSMutableArray* currentArray;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController.viewControllers count] == 2) {
        dispatch_async(dispatch_get_main_queue(), ^{
        [self loadData:nil];
        });
    }
    
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

- (void) viewDidAppear:(BOOL)animated {
    //NSLog(@"Controllers on stack = %ld", [self.navigationController.viewControllers count]);
}

- (void) returnToRoot: (id) sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[self.currentArray objectAtIndex:indexPath.row] isKindOfClass:[Employee class]]) {
        EmployeeTableViewController* evc = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeeTableViewController"];
        
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
        
        TestViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TestViewController"];
        
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
            [self showPopUp:@"Оповещение" : @"Отдел пуст" : @"ОК"];
        }
    }

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


// загрузка, парсинг json GetAll и вывод в таблицу 0 уровень
- (void) loadData:(id)sender {
    [self.currentArray removeAllObjects];
    [self.tableView reloadData];
    
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

- (void) printCannotLoad {
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self showPopUp:@"Ошибка" : @"Ошибка при выполнении запроса. Попробуйте снова." : @"ОК"];
    });
}

- (void) showPopUp: (NSString*) title : (NSString*) message : (NSString*) actionTitle{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:actionTitle
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    [alertController addAction:actionCancel];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) logout:(id)sender {
    NSString *storage = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:storage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.currentArray removeAllObjects];
    [self.tableView reloadData];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
