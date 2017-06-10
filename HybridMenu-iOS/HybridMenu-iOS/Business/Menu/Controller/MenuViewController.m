//
//  MenuViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/4.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuCollectionViewController.h"
#import "SegmentView.h"
@interface MenuViewController ()<SegmentViewScrollerViewDelegate>
@property NSMutableArray <MenuCollectionViewController *>*array;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titleArray = @[@"甜品",@"面食",@"素菜",@"养生汤",@"炒菜"];
    self.array = [NSMutableArray array];
    for (int i = 0; i<titleArray.count; i++) {
        MenuCollectionViewController *vc = [[MenuCollectionViewController alloc]initWithID:@(i+1)];
        [self addChildViewController:vc];
        vc.title = titleArray[i];
        [self.array addObject:vc];
    }
    SegmentView * segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, HEADBARHEIGHT, SCREENWIDTH, SCREENHEIGHT-HEADBARHEIGHT-TABBARHEIGHT) andControllers:self.array];
    segmentView.eventDelegate = self;
    [self.view addSubview:segmentView];
    [self.array[0] loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index{
    [self.array[index] loadData];
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
