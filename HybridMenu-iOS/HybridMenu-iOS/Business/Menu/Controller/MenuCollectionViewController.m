//
//  MenuCollectionViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/6.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MenuCollectionViewController.h"
#import "MenuListModel.h"
#import "MenuListCollectionViewCell.h"
#import "LoginHandler.h"
#import "MenuWebViewController.h"
@interface MenuCollectionViewController ()
@property NSMutableArray <MenuListModel *>*dataArray;
@property NSNumber *sort_id;
@property NSInteger page;
@property MBProgressHUD *hud;
@property UIView *whiteView;
@property MenuColloectType type;
@end

static NSString * const reuseIdentifier = @"MenuListCell";

@implementation MenuCollectionViewController

- (instancetype)initWithID:(NSNumber *)sord_id menuColloectType:(MenuColloectType)menuColloectType{
    self = [self initWithCollectionViewLayout:[UICollectionViewLayout new]];
    if (self) {
        self.type = menuColloectType;
        self.sort_id = sord_id;
        self.dataArray = [NSMutableArray array];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
        self.collectionView.collectionViewLayout = layout;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MenuListCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.whiteView = [[UIWebView alloc]initWithFrame:CGRectMake(0, HEADBARHEIGHT, SCREENWIDTH, SCREENHEIGHT-HEADBARHEIGHT-TABBARHEIGHT)];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    self.hud = [MBProgressHUD showHUDAddedTo:self.whiteView animated:YES];
    [self.view addSubview:self.whiteView];
    self.collectionView.mj_header.hidden = YES;
    self.collectionView.mj_footer.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setWhiteViewFrame:(CGRect)frame{
    self.whiteView.frame = frame;
}

- (void)headerRefresh{
    self.page = 1;
    [self getData];
}

- (void)footerRefresh{
    self.page++;
    [self getData];
}

- (void)loadData{
    if (self.whiteView.hidden == NO) {
        [self headerRefresh];
    }
}

- (void)getData{
    //1:甜品 2:面食 3:素菜 4:养生汤 5:炒菜
    NSString *api;
    NSString *user_id = [UserDefaultUtility getUserID]?:@"";
    NSMutableDictionary *paramters = @{@"user_id":user_id,@"page_num":@(self.page)}.mutableCopy;
    if (self.type == Menu) {
        api = LISTAPI;
        [paramters setObject:self.sort_id forKey:@"sort_id"];
    }
    else{
        api = COLLECTDETAILAPI;
    }
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:api method:HttpRequestGet parameters:paramters prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.hud hideAnimated:YES];
        [self.whiteView removeFromSuperview];
        if(self.type == Menu){
            if (self.page == 1) {
                self.dataArray = [NSMutableArray array];
            }
            NSArray *array = responseObject[@"message"][@"data"];
            self.page = [responseObject[@"message"][@"currentPage"] integerValue];
            for (int i = 0 ; i<array.count; i++) {
                MenuListModel *model = [[MenuListModel alloc]initWithDic:array[i]];
                [self.dataArray addObject:model];
            }
            if (self.page == [responseObject[@"message"][@"totalPages"] integerValue]) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                [self.collectionView.mj_footer endRefreshing];
            }
        }
        else{
            NSArray *array = responseObject[@"message"];
            for (int i = 0 ; i<array.count; i++) {
                MenuListModel *model = [[MenuListModel alloc]initWithDic:array[i]];
                model.isMyCollect = true;
                [self.dataArray addObject:model];
            }
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        self.whiteView.hidden = YES;
        self.collectionView.mj_header.hidden = NO;
        self.collectionView.mj_footer.hidden = NO;
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
  
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    MenuListModel *model = self.dataArray[indexPath.row];
    [cell.albumImageView sd_setImageWithURL:[NSURL URLWithString:model.menu_albums]];
    cell.titleLabel.text  = model.menu_title;
    cell.introduceLabel.text = model.menu_introduce;
    cell.likeLabel.text = model.menu_like.stringValue;
    cell.collectLabel.text = model.menu_collect.stringValue;
    cell.collectBtn.tag = indexPath.row;
    cell.collectBtn.selected = model.isMyCollect;
    [cell.collectBtn addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *menu_id = self.dataArray[indexPath.row].menu_id;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.cxy91.cn/user/page?menu_id=%@&user_id=%@",menu_id,[UserDefaultUtility getUserID]]];
    MenuWebViewController *vc = [[MenuWebViewController alloc]initWithRequest:[NSURLRequest requestWithURL:url]];
    vc.title = self.dataArray[indexPath.row].menu_title;
    if (self.type==Collect) {
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        [self.parentViewController.navigationController pushViewController:vc animated:YES];
    }
}

- (void)collectAction:(UIButton *)sender{
    NSString *user_id = [UserDefaultUtility getUserID];
    
    if (user_id ==nil) {
        [LoginViewController noLoginWith:self successBlock:^(id obj) {
            [self headerRefresh];
            [self collectAction:sender];
        } failedBlock:^(id obj) {
            
        }];
    }
    else{
        if (!sender.selected) {
            MenuListModel *model = self.dataArray[sender.tag];
            NSDictionary *parameters = @{@"user_id":user_id,@"type":@"menu_collect",@"menu_id":model.menu_id};
            model.menu_collect = @(model.menu_collect.integerValue + 1);
            [self.collectionView reloadData];
            HttpClient *client = [HttpClient defaultClient];
            model.isMyCollect = YES;
            [client requestWithPath:COLLECTAPI method:HttpRequestPost parameters:parameters prepareExecute:^{
                
            } progress:^(NSProgress *progress) {
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
        }
        else{
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"已经收藏" message:@"你已经收藏过啦=。=" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertC addAction:cancel];
            [alertC addAction:confirm];
            [self presentViewController:alertC animated:YES completion:nil];
        }
    }
}

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
