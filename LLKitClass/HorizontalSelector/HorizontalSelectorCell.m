//
//  HorizontalSelectorCell.m
//  News
//
//  Created by Lilong on 2016/12/14.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "HorizontalSelectorCell.h"
#import "YYKit.h"

@implementation HorizontalSelectorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+ (CGSize)cellSizeWithTitle:(NSString *)title
{
    if (!title)
    {
        return CGSizeZero;
    }
    CGFloat width = [title sizeForFont:[UIFont systemFontOfSize:14] size:CGSizeMake(CGFLOAT_MAX, 20) mode:NSLineBreakByWordWrapping].width;
    return CGSizeMake(width + 30, 40);
}

- (void)setSelected:(BOOL)selected
{
    if (selected)
    {
        self.titleLabel.textColor = [UIColor blackColor];
        self.underLine.hidden = NO;
    }
    else
    {
        self.titleLabel.textColor = [UIColor colorWithHexString:@"#989898"];
        self.underLine.hidden = YES;
    }
}

- (void)setTitle:(NSString *)title
{
    if (!title) return;
    CGFloat width = [title sizeForFont:[UIFont systemFontOfSize:14] size:CGSizeMake(CGFLOAT_MAX, 20) mode:NSLineBreakByWordWrapping].width;
    self.titleLabel.width = width;
    self.titleLabel.text = title;
}

@end
