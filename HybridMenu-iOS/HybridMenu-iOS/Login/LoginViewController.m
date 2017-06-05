//
//  LoginViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/5/30.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "LoginViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)login{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = @"正在登录";
    [self verifyUserInfo];
}


- (void)verifyUserInfo {
//    NSString *userID = [LoginEntry getByUserdefaultWithKey:@"user_id"];
//    NSString *password = [LoginEntry getByUserdefaultWithKey:@"password"];
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
