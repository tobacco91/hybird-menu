//
//  MineViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/4.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "MenuCollectionViewController.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property NSMutableArray *cellDictionaryArray;
@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [self reloadHeadImage];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellDictionaryArray = @[
                        @{@"title":@"我的收藏",@"controller":@"MyCollectViewController",
                          @"img":@"mine_img_collect",
                          @"color":@"ff9955"},
                         @{@"title":@"意见反馈",@"img":@"mine_img_suggest",@"controller":@"SuggestionViewController",
                           @"color":@"ffb06c"},
                         @{@"title":@"关于我们",@"controller":@"AboutViewController",
                           @"color":@"ffbf63",
                           @"img":@"mine_img_about"},
                         @{@"title":@"退出账号",
                           @"color":@"c5cc8c",
                           @"img":@"mine_img_quit"}
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
        _tableView.backgroundColor = [UIColor colorWithHexString:@"202931"];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellDictionaryArray.count+1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
       UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT*1/2)];
        UIButton *head = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        if([UserDefaultUtility getUserID]){
            [head setBackgroundImage:[UIImage imageNamed:@"mine_img_head"] forState:UIControlStateNormal];
        }
        else{
            [head setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        }
        head.layer.cornerRadius = head.width/2;
        head.layer.masksToBounds =YES;
        [head setTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        lb.textColor = [UIColor whiteColor];
        lb.font = [UIFont systemFontOfSize:10];
        lb.text = [UserDefaultUtility valueWithKey:@"userName"]?:@"登录/注册";
        lb.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:head];
        [cell addSubview:lb];
        cell.backgroundColor = [UIColor colorWithHexString:@"202931"];
        [head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.mas_centerX);
            make.width.and.height.equalTo(@60);
            make.top.equalTo(cell.mas_top).offset(70);
            make.bottom.equalTo(lb.mas_top).offset(-8);
        }];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.mas_centerX);
            make.left.equalTo(@8);
            make.right.equalTo(@(-8));
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }
    else{
        static NSString *identifier = @"MineTableViewCell";
        MineTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        NSDictionary *dic = self.cellDictionaryArray[indexPath.row-1];
        if(!cell){
            cell = [[[NSBundle mainBundle]loadNibNamed:identifier owner:self options:nil] lastObject];
            if (indexPath.row >=2) {
                NSDictionary *dic1 = self.cellDictionaryArray[indexPath.row-2];
                cell.cornerColor = [UIColor colorWithHexString:dic1[@"color"]];
            }
            else{
                cell.cornerColor = [UIColor colorWithHexString:@"202931"];
            }
            cell.photoView.image = [UIImage imageNamed: dic[@"img"]];
            cell.titleLabel.text = dic[@"title"];
            cell.backgroundColor = [UIColor colorWithHexString:dic[@"color"]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_img_indicator"]];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return (SCREENHEIGHT-HEADBARHEIGHT)/2;
    }
    return (SCREENHEIGHT-HEADBARHEIGHT)*1/8;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        NSString *className =self.cellDictionaryArray[indexPath.row-1][@"controller"];
        NSString *title = self.cellDictionaryArray[indexPath.row-1][@"title"];
        UIViewController *viewController =  (UIViewController *)[[NSClassFromString(className) alloc] init];
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == self.cellDictionaryArray.count) {
            if (![UserDefaultUtility getUserID]) {
                [LoginViewController noLoginWith:self successBlock:^(id obj) {
                    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
                } failedBlock:^(id obj) {
                    
                }];
                return;
            }
        }
        if(indexPath.row==1){
            MenuCollectionViewController *vc = [[MenuCollectionViewController alloc]initWithID:nil menuColloectType:Collect];
            [vc loadData];
            vc.hidesBottomBarWhenPushed = YES;
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        if(indexPath.row == self.cellDictionaryArray.count){
            [self loginOut];
            return;
        }
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.title = title;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)login{
    if (![UserDefaultUtility getUserID]) {
        LoginViewController *lvc = [[LoginViewController alloc]initWithSuccessBlock:^(id obj) {
            [self reloadHeadImage];
        } failedBlock:nil];
        [self.navigationController presentViewController:lvc animated:YES completion:^{
            
        }];
    }
}

- (void)loginOut{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登出帐号"
                                                                   message:@"所有的个人信息将清除,你确定要登出此帐号吗?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定"                          style:UIAlertActionStyleDestructive                        handler:^(UIAlertAction * _Nonnull action) {
        [LoginEntry loginoutWithParamArrayString:@[@"user_id"]];
        [self reloadHeadImage];
    }];
    [alert addAction:defaultAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"                               style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    return;
}


- (void)reloadHeadImage{
    [self.tableView reloadRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] withRowAnimation:UITableViewRowAnimationAutomatic];

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
