//
//  UIColor+Config.h
//  News
//
//  Created by Lilong on 2016/12/13.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (Config)    // App 颜色配置

/**
 16 进制转 UIColor
 
 @param str   16进制字符串，如 【@"#090909"】
 @param alpha 透明度
 
 @return  UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)str
                          alpha:(CGFloat)alpha;


/**
 列表分割线颜色
 
 @return UIColor
 */
+ (UIColor *)listSeparateColor;


/**
 ViewController 默认背景颜色
 
 @return #F8F8F8
 */
+ (UIColor *)defaulViewBackgroundColor;

@end
