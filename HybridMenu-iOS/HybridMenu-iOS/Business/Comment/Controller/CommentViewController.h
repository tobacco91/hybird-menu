//
//  CommentViewController.h
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/14.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, CommentType) {
    Reply,
    Comment,
};
@interface CommentViewController : BaseViewController
- (instancetype)initWithCommentType:(CommentType)type andID:(NSString *)ID;
@end
