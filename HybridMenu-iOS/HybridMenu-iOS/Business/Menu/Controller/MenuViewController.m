//
//  MenuViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/4.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuListViewController.h"
#import "SegmentView.h"
@interface MenuViewController ()
@property NSMutableArray <MenuListViewController *>*array;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titleArray = @[@"甜品",@"面食",@"素菜",@"养生汤",@"炒菜"];
    self.array = [NSMutableArray array];
    for (int i = 0; i<titleArray.count; i++) {
        MenuListViewController *listVC = [[MenuListViewController alloc]init];
        listVC.title = titleArray[i];
        [self.array addObject:listVC];
    }
    SegmentView * segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) andControllers:self.array];
    [self.view addSubview:segmentView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData{
    //1:甜品 2:面食 3:素菜 4:养生汤 5:炒菜
    
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
