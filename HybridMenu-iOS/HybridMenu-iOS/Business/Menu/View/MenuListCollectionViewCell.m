//
//  MenuListCollectionViewCell.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/4.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MenuListCollectionViewCell.h"

@implementation MenuListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"menu_img_collect"] forState:UIControlStateNormal];
//    [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"menu_img_look"] forState:UIControlStateNormal];
    
    self.likeLabel.textColor = self.collectLabel.textColor = self.introduceLabel.textColor = [UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1];
    self.likeLabel.font = self.collectLabel.font =
    self.introduceLabel.font = [UIFont systemFontOfSize:10];
    [self.likeBtn setBackgroundImage:[UIImage imageNamed:@"menu_img_look"] forState:UIControlStateNormal];
    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"menu_img_collect"] forState:UIControlStateNormal];
    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"menu_img_collected"] forState:UIControlStateSelected];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.likeBtn.adjustsImageWhenHighlighted = NO;
    self.collectBtn.adjustsImageWhenHighlighted = NO;
    // Initialization code
}

@end
