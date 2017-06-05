//
//  MenuListModel.h
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/4.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuListModel : NSObject
@property NSNumber *menu_id;
@property NSString *menu_title;
@property NSString *menu_introduce;
@property NSString *menu_albums;
@property NSNumber *menu_like;
@property NSNumber *menu_collect;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
