//
//  MenuCollectionViewController.h
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/6.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "BaseCollectionViewController.h"
typedef NS_ENUM(NSInteger, MenuColloectType) {
    Menu,
    Collect,
};

@interface MenuCollectionViewController : BaseCollectionViewController
- (instancetype)initWithID:(NSNumber *)sord_id menuColloectType:(MenuColloectType)menuColloectType;
- (void)loadData;
- (void)setWhiteViewFrame:(CGRect)frame;
@end
