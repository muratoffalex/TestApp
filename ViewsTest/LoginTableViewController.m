//
//  LoginTableViewController.m
//  ViewsTest
//
//  Created by admin on 17.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "LoginTableViewController.h"
#import "TestViewController.h"
#import "DataManager.h"

@interface LoginTableViewController ()

@end

@implementation LoginTableViewController
{
    NSArray* arrayCells;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton* testButton = [UIButton new];
    
    [testButton setTitle:@"Быстрый вход" forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    testButton.backgroundColor = [UIColor redColor];
    testButton.layer.cornerRadius = 10;
    testButton.clipsToBounds = YES;
    [testButton sizeToFit];
    
    [self.view addSubview:testButton];
    [testButton addTarget:self
                   action:@selector(quickEntry:)
         forControlEvents:UIControlEventTouchUpInside];
    
    [testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        //make.width.equalTo(@200);
        make.height.equalTo(@40);
        make.leadingMargin.equalTo(@80);
        make.top.equalTo(@245);
    }];
    
    UIImageView* tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBack"]];
    [tempImageView setFrame: self.tableView.frame];
    self.tableView.backgroundView = tempImageView;
    [self.tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
    self.navigationItem.title = @"Адресная книга";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    _loginCell = [[LoginTableCell alloc] init];
    _passCell = [[PassTableCell alloc] init];
    
    _entryCell = [[EntryTableCell alloc] init];
    [_entryCell.entryButton addTarget:self
                               action:@selector(loginButtonTapped:)
                     forControlEvents:UIControlEventTouchUpInside];
    
    _rememberCell = [[RememberTableCell alloc] init];
    
    arrayCells = @[_loginCell, _passCell, _entryCell, _rememberCell];
    
    self.loginCell.loginTextField.delegate = self;
    self.passCell.passTextField.delegate = self;
    
    self.loginCell.loginTextField.text = @"test_user";
    self.passCell.passTextField.text = @"test_pass";
    
    if ([DataManager sharedInstance].status == 1) {
        TestViewController * detail = [[TestViewController alloc] init];
        [self.navigationController pushViewController:detail animated:NO];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) quickEntry: (UIButton*) sender {
    [DataManager sharedInstance].login = @"test_user";
    [DataManager sharedInstance].password = @"test_pass";
    
    BOOL isOn = [_rememberCell.rememberSwitch isOn];
    [[DataManager sharedInstance] saveUserData:isOn];
    
    TestViewController * detail = [[TestViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
    
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:cellIdentifier];
    }
    
    cell = [arrayCells objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayCells count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *headerTitle;
    if (section==0) {
        headerTitle = @"Авторизация";
    }
    return headerTitle;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[arrayCells objectAtIndex:indexPath.row] rowHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

        switch (indexPath.row) {
            case 3:
                if ([_rememberCell.rememberSwitch isOn]) {
                    [_rememberCell.rememberSwitch setOn:NO animated:YES];
                } else {
                    [_rememberCell.rememberSwitch setOn:YES animated:YES];
                }
            break;
        }
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == _loginCell.loginTextField) {
        [_loginCell.loginTextField resignFirstResponder];
        [_passCell.passTextField becomeFirstResponder];
    } else if (textField == _passCell.passTextField) {
        [_passCell.passTextField resignFirstResponder];
    } else {
        [textField resignFirstResponder];
    }

    return YES;
}

#pragma mark - Click button login

- (void)loginButtonTapped:(UIButton *)sender {
    
    [self.tableView endEditing:YES];
    
    if (![_loginCell.loginTextField.text isEqualToString:@""] && ![_passCell.passTextField.text isEqualToString:@""]) {
        
        NSString* formatURL = [NSString stringWithFormat:@"https://contact.taxsee.com/Contacts.svc/Hello?login=%@&password=%@", _loginCell.loginTextField.text, _passCell.passTextField.text];
        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:formatURL]];
        [request setHTTPMethod:@"GET"];
        NSURLSession* session = [NSURLSession sharedSession];
        NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
            if (data == nil) {
                [[DataManager sharedInstance] printCannotLoad:self];
            } else {
                [self getAnswer:data];
            }
        }];
        
        [task resume];
    } else {
        [[DataManager sharedInstance] showPopUp:@"Ошибка" : @"Логин или пароль не могут быть пустыми!" : @"Повторить ввод": self];
    }
}

- (void) getAnswer:(NSData *) jsonData {
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:jsonData
                 options:0
                 error:&error];
    
    if(error) {
        
        return;
    }
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSString* success = [object valueForKey:@"Success"];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if ([[NSString stringWithFormat:@"%@", success] isEqual: @"1"]) {
                
                [DataManager sharedInstance].login = _loginCell.loginTextField.text;
                [DataManager sharedInstance].password = _passCell.passTextField.text;
                
                _loginCell.loginTextField.text = @"";
                _passCell.passTextField.text = @"";
                
                BOOL isOn = [_rememberCell.rememberSwitch isOn];
                [[DataManager sharedInstance] saveUserData:isOn];
                
                NSLog(@"SUCCESS");
                TestViewController * detail = [[TestViewController alloc] init];
                [self.navigationController pushViewController:detail animated:YES];
            } else {
                [[DataManager sharedInstance] showPopUp:@"Ошибка" : @"Неправильный логин или пароль." : @"Повторить ввод": self];
            }
            
        });
    } else {
    }
}

@end
