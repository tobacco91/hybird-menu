//
//  MenuListModel.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/4.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MenuListModel.h"

@implementation MenuListModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    self = [self init];
    if (self) {
        self.menu_id = dic[@"menu_id"];
        self.menu_title = dic[@"menu_title"];
        self.menu_introduce = dic[@"menu_introduce"];
        self.menu_albums = [ALBUMSAPI stringByAppendingString:dic[@"menu_albums"]];
        self.menu_like = dic[@"menu_like"];
        self.menu_collect = dic[@"menu_collect"];
        self.isMyCollect = [dic[@"collect"] boolValue];
    }
    return self;
}
@end
