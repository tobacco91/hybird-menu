//
//  LoginHandler.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/4.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "LoginHandler.h"

@implementation LoginHandler
+ (void)noLogin:(UIViewController *)viewController{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"是否登录？" message:@"尚未登录,不能收藏" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再看看" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *LVC = [[LoginViewController alloc] init];
        [viewController.navigationController pushViewController:LVC animated:YES];
    }];
    [alertC addAction:cancel];
    [alertC addAction:confirm];
    [viewController presentViewController:alertC animated:YES completion:nil];
}
@end
