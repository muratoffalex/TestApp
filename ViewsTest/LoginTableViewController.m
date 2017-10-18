//
//  LoginTableViewController.m
//  ViewsTest
//
//  Created by admin on 17.10.17.
//  Copyright © 2017 admin. All rights reserved.
//

#import "LoginTableViewController.h"
#import "TestViewController.h"

@interface LoginTableViewController ()

@end

@implementation LoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView* tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loginBack"]];
//    [tempImageView setFrame: self.tableView.frame];
//    self.tableView.backgroundView = tempImageView;
    
    self.loginInput.delegate = self;
    self.passInput.delegate = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.status = [defaults integerForKey:@"status"];
    
    if (self.status == 1) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TestViewController * detail = [storyboard instantiateViewControllerWithIdentifier:@"TestViewController"];
        [self.navigationController pushViewController:detail animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

//- (void) viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:YES];
//
//    [self.navigationController setNavigationBarHidden:YES];
//}
//
//- (void) viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:YES];
//
//    [self.navigationController setNavigationBarHidden:YES];
//}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == _loginInput) {
        [_loginInput resignFirstResponder];
        [_passInput becomeFirstResponder];
    } else if (textField == _passInput) {
        [_passInput resignFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return TRUE;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:TRUE];
}

- (IBAction)loginButtonTapped:(UIButton *)sender {
    
    [self.tableView endEditing:TRUE];
    
    if (![_loginInput.text isEqualToString:@""] && ![_passInput.text isEqualToString:@""]) {
        
        NSString* formatURL = [NSString stringWithFormat:@"https://contact.taxsee.com/Contacts.svc/Hello?login=%@&password=%@", _loginInput.text, _passInput.text];
        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:formatURL]];
        [request setHTTPMethod:@"GET"];
        NSURLSession* session = [NSURLSession sharedSession];
        NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
            if (data == nil) {
                [self printCannotLoad];
            } else {
                [self getAnswer:data];
            }
        }];
        
        [task resume];
    } else {
        [self showPopUp:@"Ошибка" : @"Логин или пароль не могут быть пустыми!" : @"Повторить ввод"];
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
                TestViewController* testViewController = [[TestViewController alloc] init];
                
                testViewController.login = _loginInput.text;
                testViewController.password = _passInput.text;
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                [defaults setInteger:1 forKey:@"status"];
                [defaults setValue:_loginInput.text forKey:@"login"];
                [defaults setValue:_passInput.text forKey:@"password"];
                [defaults synchronize];
                
                _loginInput.text = @"";
                _passInput.text = @"";
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                TestViewController * detail = [storyboard instantiateViewControllerWithIdentifier:@"TestViewController"];
                [self.navigationController pushViewController:detail animated:YES];
                
            } else {
                [self showPopUp:@"Ошибка" : @"Неправильный логин или пароль." : @"Повторить ввод"];
            }
            
        });
    } else {
    }
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



@end
