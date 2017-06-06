//
//  MenuCollectionViewController.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/6.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MenuCollectionViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MenuListModel.h"
#import "MenuListCollectionViewCell.h"
@interface MenuCollectionViewController ()
@property NSMutableArray *dataArray;
@property NSNumber *sort_id;
@end

static NSString * const reuseIdentifier = @"MenuListCell";

@implementation MenuCollectionViewController

- (instancetype)initWithID:(NSNumber *)sord_id{
    self = [self initWithCollectionViewLayout:[UICollectionViewLayout new]];
    if (self) {
        self.sort_id = sord_id;
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
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    [self headerRefresh];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)headerRefresh{
    self.dataArray = [NSMutableArray array];
    [self getData];
}

- (void)footerRefresh{
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
}

- (void)getData{
    //1:甜品 2:面食 3:素菜 4:养生汤 5:炒菜
    NSDictionary *paramters = @{@"sort_id":self.sort_id};
    HttpClient *client = [HttpClient defaultClient];
    [client requestWithPath:LISTAPI method:HttpRequestGet parameters:paramters prepareExecute:^{
        
    } progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = responseObject[@"message"];
        for (int i = 0 ; i<array.count; i++) {
            MenuListModel *model = [[MenuListModel alloc]initWithDic:array[i]];
            [self.dataArray addObject:model];
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
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
    // Configure the cell
    cell.likeLabel.text = model.menu_like.stringValue;
    cell.collectLabel.text = model.menu_collect.stringValue;
    return cell;
}



#pragma mark <UICollectionViewDelegate>

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
