//
//  SegmentView.h
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/4.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SegmentViewScrollerViewDelegate <NSObject>

@required

- (void)eventWhenScrollSubViewWithIndex:(NSInteger)index;

@end

@interface SegmentView : UIView
- (instancetype)initWithFrame:(CGRect)frame andControllers:(NSArray <UIViewController *> *)controllers;
@property (weak,nonatomic) id<SegmentViewScrollerViewDelegate> eventDelegate;

@end
