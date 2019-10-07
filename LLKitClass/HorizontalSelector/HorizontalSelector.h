//
//  HorizontalSelector.h
//  News
//
//  Created by Lilong on 2016/12/14.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalSelector : UIView
@property (copy, nonatomic) NSArray * titles;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (copy, nonatomic) void (^itemSelectedBlock) (NSInteger index);
+ (instancetype)initSelectorWithFrame:(CGRect)frame;
@end
