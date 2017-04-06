//
//  HUD.m
//  DrWaterproof
//
//  Created by Lilong on 16/6/23.
//  Copyright © 2016年 施鱼科技. All rights reserved.
//

#import "LLHud.h"

@implementation LLHud

+(MBProgressHUD *)showHUDInView:(UIView *)view title:(NSString *)title{
    if (view == nil) {
        return nil;
    }
    // 禁止TableView滚动
    if ([view respondsToSelector:@selector(setScrollEnabled:)]) {
        [(UIScrollView*)view setScrollEnabled:NO];
    }
    MBProgressHUD *HUDInView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUDInView.center=CGPointMake(view.center.x, view.center.y - view.frame.origin.y);
    
    HUDInView.removeFromSuperViewOnHide = YES;
    HUDInView.labelText = title;
    HUDInView.square = YES;
    HUDInView.mode = MBProgressHUDModeCustomView;
    HUDInView.layer.cornerRadius = 4.0f;
    HUDInView.layer.masksToBounds = YES;
    HUDInView.alpha=1.0;
    HUDInView.yOffset=5;
    HUDInView.labelFont=[UIFont boldSystemFontOfSize:14.0f];
    HUDInView.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0f];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 50, 50);
    NSMutableArray *imageList = [[NSMutableArray alloc] initWithCapacity:24];
    for (NSInteger i = 1; i <= 12; i++) {
        UIImage *frameImage = [UIImage imageNamed:[NSString stringWithFormat:@"%lu",(unsigned long)i]];
        if (frameImage) {
            [imageList addObject:frameImage];
        }
    }
    [imageView setAnimationImages:imageList];
    [imageView setAnimationDuration:0.6];
    [imageView startAnimating];
    
    HUDInView.customView = imageView;
    return HUDInView;
}

+(void)hideHUDInView:(UIView *)view{
    if (view == nil) {
        return;
    }
    // 允许TableView滚动
    if ([view respondsToSelector:@selector(setScrollEnabled:)]) {
        [(UIScrollView*)view setScrollEnabled:YES];
    }
    
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
}

+(MBProgressHUD *)showNetWorkErrorInView:(UIView *)view{
    if (view == nil) {
        return nil;
    }
    // 允许TableView滚动
    if ([view respondsToSelector:@selector(setScrollEnabled:)]) {
        [(UIScrollView*)view setScrollEnabled:YES];
    }
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    MBProgressHUD *HUDInView = [MBProgressHUD showHUDAddedTo:view animated:NO];
    HUDInView.removeFromSuperViewOnHide = YES;
    HUDInView.mode = MBProgressHUDModeText;
    HUDInView.labelText = @"网络请求失败，请稍候再试";
    HUDInView.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0f];
    [HUDInView hide:YES afterDelay:1.5];
    return HUDInView;
}

+(MBProgressHUD *)showMessageInView:(UIView *)view title:(NSString *)title{
    if (view == nil) {
        return nil;
    }
    // 允许TableView滚动
    if ([view respondsToSelector:@selector(setScrollEnabled:)]) {
        [(UIScrollView*)view setScrollEnabled:YES];
    }
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    //屏幕中心
    MBProgressHUD *HUDInView = [MBProgressHUD showHUDAddedTo:view animated:NO];
    HUDInView.removeFromSuperViewOnHide = YES;
    HUDInView.mode = MBProgressHUDModeText;
    HUDInView.detailsLabelText = title;
    HUDInView.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0f];
    [HUDInView hide:YES afterDelay:1.5];
    return HUDInView;
}


//显示信息
+(MBProgressHUD *)showMessageInView:(UIView *)view title:(NSString *)title interval:(NSTimeInterval)seconds {
    if (view == nil) {
        return nil;
    }
    // 允许TableView滚动
    if ([view respondsToSelector:@selector(setScrollEnabled:)]) {
        [(UIScrollView*)view setScrollEnabled:YES];
    }
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    //屏幕中心
    MBProgressHUD *HUDInView = [MBProgressHUD showHUDAddedTo:view animated:NO];
    HUDInView.removeFromSuperViewOnHide = YES;
    HUDInView.mode = MBProgressHUDModeText;
    HUDInView.detailsLabelText = title;
    HUDInView.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0f];
    [HUDInView hide:YES afterDelay:seconds];
    return HUDInView;
}
@end
