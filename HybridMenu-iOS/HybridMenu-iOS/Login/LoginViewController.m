//
//  LoginViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/5/30.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginEntry.h"
#import "LoginHandler.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
@property LoginHandler *handler;
@property MBProgressHUD *hud;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    self.passwordTextField.secureTextEntry = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.label.text = @"正在登录";
    [self.hud hideAnimated:YES afterDelay:1.5];
    [self verifyUserInfo];
}

- (void)registerAction{
    RegisterViewController *vc = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)verifyUserInfo {
    HttpClient *client = [HttpClient defaultClient];
    NSDictionary *paramters = @{@"name":self.accountTextField.text,@"password":self.passwordTextField.text};
    [client requestWithPath:LOGINAPI method:HttpRequestPost parameters:paramters prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"status"] isEqualToNumber:@200]) {
            [LoginEntry loginWithUserName:paramters[@"name"] passworld:paramters[@"password"] withDictionaryParam:responseObject[@"message"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.label.text = responseObject[@"message"];
            self.hud.mode = MBProgressHUDModeText;
            [self.hud hideAnimated:YES afterDelay:1];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.label.text = @"网络问题";
        self.hud.mode = MBProgressHUDModeText;
        [self.hud hideAnimated:YES afterDelay:1];
    }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
