//
//  HUD.h
//  DrWaterproof
//
//  Created by Lilong on 16/6/23.
//  Copyright © 2016年 施鱼科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface LLHud : NSObject

//显示HUD提示
+(MBProgressHUD *)showHUDInView:(UIView *)view title:(NSString *)title;

//关闭HUD提示
+(void)hideHUDInView:(UIView *)view;

//显示网络错误提示
+(MBProgressHUD *)showNetWorkErrorInView:(UIView *)view;

//显示信息
+(MBProgressHUD *)showMessageInView:(UIView *)view title:(NSString *)title;

//显示信息
+(MBProgressHUD *)showMessageInView:(UIView *)view title:(NSString *)title interval:(NSTimeInterval)seconds;

@end
