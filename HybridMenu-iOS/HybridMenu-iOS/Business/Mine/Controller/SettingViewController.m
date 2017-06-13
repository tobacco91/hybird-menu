//
//  SettingViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/13.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property NSMutableArray *cellArray;
@end

@implementation SettingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.cellArray = @[@{@"cell":@"意见与反馈", @"controller":@"SuggestionViewController"},
                   @{@"cell":@"关于", @"controller":@"AboutViewController"},
                   @{@"cell":@"设置课前提醒"},
                   @{@"cell":@"退出当前账号"},
                   ].mutableCopy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView{
    if (_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
#pragma mark - TableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 43;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        NSString *className =  _cellArray[indexPath.row][@"controller"];
        UIViewController *viewController =  (UIViewController *)[[NSClassFromString(className) alloc] init];
        viewController.navigationItem.title = _cellArray[indexPath.row][@"cell"];
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登出帐号"
                                                                       message:@"所有的个人信息将清除,你确定要登出此帐号吗?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  [self logOut];
                                                              }];
        [alert addAction:defaultAction];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)logOut {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    id view = [storyBoard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [LoginEntry loginoutWithParamArrayString:@[@"lessonResponse", @"nowWeek", @"user_id", @"id", @"stuname", @"introduction", @"username", @"nickname", @"gender", @"photo_thumbnail_src", @"photo_src", @"updated_time", @"phone", @"qq",@"switchState"]];
    [self.navigationController presentViewController:view animated:YES completion:nil];
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
