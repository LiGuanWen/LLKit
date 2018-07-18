//
//  LLSegmentView.h
//  News
//
//  Created by Lilong on 2016/12/13.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLSegmentView : UIView

@property (nonatomic, copy) void (^handle)(UIButton *button,NSInteger index);
@property (nonatomic, assign) NSInteger currentIndex;
/**
 构造方法
 
 @param titles 标题组数
 @return LLSegmentView实例
 */
- (instancetype)initWithSegmentTitles:(NSArray *)titles;

/**
 设置右上角小红点
 
 @param index 对应小红点索引
 */
- (void)showRedPointAtIndex:(NSInteger)index;

/**
 隐藏右上角小红点
 
 @param index 对应小红点索引
 */
- (void)hideRedPointAtIndex:(NSInteger)index;
@end
