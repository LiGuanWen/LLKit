//
//  WebViewController.h
//  PPAutoInsurance
//
//  Created by ang on 15/11/18.
//  Copyright © 2015年 PPChe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

/**
 *  根据地址初始化Web视图
 *
 *  @param urlString 目标地址
 *
 *  @return 根据urlString初始化后的Web视图
 */
+(WebViewController*)webViewControllerWithURLString:(NSString*)urlString;

/**
 *  根据地址初始化Web视图
 *
 *  @return 根据urlString初始化后的Web视图
 */
+(WebViewController*)webViewControllerWithContentString:(NSString*)contentString title:(NSString *)title;


/**
 跳转到web

 @param urlString url
 @param title 标题 （为 nil 时 使用url内容自带的）
 @param superVC 上级VC
 @param hidesBottomBarWhenPushed 是否需要隐藏tabbar
 @param obj 扩展
 @param shouldShowHud 加载显示类型
 */
+ (void)routerWebViewControllerWithURLString:(NSString*)urlString title:(NSString *)title supVC:(UIViewController *)superVC hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed obj:(id)obj shouldShowHud:(BOOL)shouldShowHud;
/**
 *  Request url string
 */
@property (nonatomic,copy) NSString *urlString;

/**
 *  Request url string
 */
@property (nonatomic,copy) NSString *contentString;

/**
 *  WebView
 */
@property (nonatomic,strong,readonly) UIWebView *webView;

/**
 *  是否显示Hud加载，默认为NO
 */
@property (nonatomic,assign) BOOL shouldShowHud;

/**
 *  是否自动根据h5中的标题设置修改当前标题
 */
@property (nonatomic,assign) BOOL shouldAutoChangeTitle;

/**
 *  加载通知，收到通知后刷新页面
 *
 *  @param notificationNames 要进行通知的数组
 */
- (void)addNotificationForReload:(NSArray*)notificationNames;

@end
