//
//  MineTableViewCell.m
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/13.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import "MineTableViewCell.h"
@implementation MineTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                     byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
             cornerRadii:CGSizeMake(10, 10)];
    UIBezierPath *mPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [maskPath appendPath:mPath];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = self.bounds;
    [maskLayer setFillRule:kCAFillRuleEvenOdd];
    maskLayer.fillColor = self.cornerColor.CGColor;
    [self.layer addSublayer:maskLayer];
}

@end
