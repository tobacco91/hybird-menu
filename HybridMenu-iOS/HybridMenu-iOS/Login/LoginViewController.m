//
//  LoginViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/5/30.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginEntry.h"

@interface LoginViewController ()
@property MBProgressHUD *hud;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *introduceLaebl;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property UIButton *selectedBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
    self.passwordTextField.secureTextEntry = YES;
    [self.loginBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:49/255.0 alpha:1] forState:UIControlStateSelected];
    [self.loginBtn setTitleColor:[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1] forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:93/255.0 blue:49/255.0 alpha:1] forState:UIControlStateSelected];
    [self.registerBtn setTitleColor:[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1] forState:UIControlStateNormal];
    self.introduceLaebl.textColor = [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1];
    self.introduceLaebl.font = [UIFont systemFontOfSize:10];
    
    
    [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"login_img_cancel"] forState:UIControlStateSelected];
    
    self.selectedBtn = self.loginBtn;
    self.selectedBtn.selected = YES;
    
    self.cancelBtn.adjustsImageWhenHighlighted = NO;
    self.checkBtn.adjustsImageWhenHighlighted = NO;
    
    
    [self.loginBtn addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerBtn addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.checkBtn addTarget:self action:@selector(loginOrRegister) forControlEvents:UIControlEventTouchUpInside];
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)changeSelect:(UIButton *)sender{
    self.selectedBtn.selected = NO;
    self.selectedBtn = sender;
    self.selectedBtn.selected = YES;
}

- (void)loginOrRegister{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *api = @"";
    if ([self.selectedBtn.currentTitle isEqualToString:@"登录"]) {
        self.hud.label.text = @"正在登录";
        api = LOGINAPI;
    }
    else{
        self.hud.label.text = @"正在注册";
        api = REGISTERAPI;
    }
    [self.hud showAnimated:YES];
    HttpClient *client = [HttpClient defaultClient];
    NSDictionary *paramters = @{@"name":self.accountTextField.text,@"password":self.passwordTextField.text};
    
    [client requestWithPath:api method:HttpRequestPost parameters:paramters prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.hud hideAnimated:YES];
        if ([[responseObject objectForKey:@"status"] isEqualToNumber:@200]) {
            [LoginEntry loginWithUserName:paramters[@"name"] passworld:paramters[@"password"] withDictionaryParam:responseObject[@"message"]];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            if (self.handler.successBlock) {
                self.handler.successBlock(nil);
//                self.handler
//                self.handler.successBlock(id obj);
            }
        }
        else{
            self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            self.hud.label.text = responseObject[@"message"];
            self.hud.mode = MBProgressHUDModeText;
            [self.hud hideAnimated:YES afterDelay:1];
            if (self.handler.failedBlock) {
                self.handler.failedBlock(nil);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.hud hideAnimated:YES];
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


+ (void)noLoginWith:(UIViewController *)viewController
       successBlock:(SuccessBlock)successBlock
        failedBlock:(FailedBlock)failedBlock
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"是否登录？" message:@"尚未登录,不能收藏" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *LVC = [[LoginViewController alloc] init];
        LVC.handler.successBlock = successBlock;
        LVC.handler.failedBlock = failedBlock;
        [viewController.navigationController presentViewController:LVC animated:YES completion:^{
            
        }];
    }];
    [alertC addAction:cancel];
    [alertC addAction:confirm];
    [viewController presentViewController:alertC animated:YES completion:nil];
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
