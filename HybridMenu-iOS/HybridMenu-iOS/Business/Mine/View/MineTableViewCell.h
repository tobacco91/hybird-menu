//
//  MineTableViewCell.h
//  HybridMenu-iOS
//
//  Created by 李展 on 2017/6/13.
//  Copyright © 2017年 JohnLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property UIColor *cornerColor;
@end
