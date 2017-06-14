//
//  MineViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/4.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property NSMutableArray *cellDictionary;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellDictionary = @[
                        @{@"title":@"我的收藏",@"controller":@"MyCollectViewController",@"img":@""},
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH,SCREENHEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
    static NSString *identifier = @"MineTableViewCell";
    MineTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    NSDictionary *dic = self.cellDictionary[indexPath.row];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:self options:nil] lastObject];
        cell.photoView = dic[@"img"];
        cell.titleLabel.text = dic[@"title"];
        
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.065*SCREENHEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *className =self.cellDictionary[indexPath.row][@"Controller"];
    UIViewController *viewController =  (UIViewController *)[[NSClassFromString(className) alloc] init];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
//    NSSet *set = [NSSet setWithObjects:@0, @1, @2, @5, @6, nil];

    
    //需账户登陆
//        if ([UserDefaultUtility getUserID]) {
//            
//        } else{
//            NSString *message;
//            if ([needLoginSet containsObject:@0]) {
//                message = @"登录后才能查看个人信息哦";
//            }
//            [LoginViewController noLoginWith:self successBlock:nil failedBlock:nil];
//        }
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
