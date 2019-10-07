//
//  HorizontalSelectorCell.h
//  News
//
//  Created by Lilong on 2016/12/14.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kHorizontalSelectorCell = @"HorizontalSelectorCell";

@interface HorizontalSelectorCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *underLine;
@property (copy, nonatomic) NSString * title;
+ (CGSize)cellSizeWithTitle:(NSString *) title;

@end
