//
//  MineViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/4.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property NSMutableArray *cellDictionary;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellDictionary = @[
                        @{@"title":@"我的收藏",@"controller":@"MyCollectViewController"},
                         @{@"title":@"设置",@"img":@"关于.png",@"controller":@"SettingViewController"},
                         ].mutableCopy;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH,SCREENHEIGHT) style:UITableViewStyleGrouped];
//        _tableView.alwaysBounceVertical = YES;
//        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        _tableView.sectionFooterHeight = 0;
//        _tableView.sectionFooterHeight = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        [_tableView setAutoresizesSubviews:NO];
//        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellDictionary.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    
    return cell;
}
//
//#pragma mark 分割tableview设置
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    NSSet *set = [NSSet setWithObjects:@1,@7, nil];
//    NSSet *nowSet = [NSSet setWithObject:[NSNumber numberWithInteger:section]];
//    if ([nowSet isSubsetOfSet:set]) {
//        return 15;
//    }else{
//        return 0.00001;
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.section == 0){
//        return 0.12*SCREENHEIGHT;
//    }
    return 0.065*SCREENHEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *className;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    NSSet *set = [NSSet setWithObjects:@0, @1, @2, @5, @6, nil];
    NSSet *needLoginSet = [NSSet setWithObject: [NSNumber numberWithInteger:indexPath.section]];
    
    //需账户登陆
        if ([UserDefaultUtility getUserID]) {
            
        } else{
            NSString *message;
            if ([needLoginSet containsObject:@0]) {
                message = @"登录后才能查看个人信息哦";
            }
            [LoginViewController noLoginWith:self successBlock:nil failedBlock:nil];
        }
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
