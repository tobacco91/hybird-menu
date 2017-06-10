//
//  MainTabBarController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/5/30.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MainTabBarController.h"
#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"
@interface MainTabBarController ()<UITabBarDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    NSArray *childItemsArray = @[
//                                 @{kClassKey  : @"RecommendViewController",
//                                   kTitleKey  : @"推荐",
//                                   kImgKey    : @"tabbar_img_daily",
//                                   kSelImgKey : @"tabbar_img_daily"},
                                 
                                 @{kClassKey  : @"MenuViewController",
                                   kTitleKey  : @"菜谱",
                                   kImgKey    : @"tabbar_img_menu",
                                   kSelImgKey : @"tabbar_img_menu"},
                                 
                                 @{kClassKey  : @"MineViewController",
                                   kTitleKey  : @"我",
                                   kImgKey    : @"tabbar_img_mine",
                                   kSelImgKey : @"tabbar_img_mine"} ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.navigationBar.backgroundColor = [UIColor whiteColor];
        nav.navigationBar.barTintColor = [UIColor whiteColor];
        
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
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
