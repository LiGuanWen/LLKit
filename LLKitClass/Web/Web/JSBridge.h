//
//  PPJSBridge.h
//  PPAutoInsurance
//
//  Created by ang on 15/11/18.
//  Copyright © 2015年 PPChe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewController.h"
#import "WebViewJavascriptBridge.h"

@interface JSBridge : NSObject

- (void)addBridgeTo:(UIWebView*)webView controller:(WebViewController*)webViewController;


//#pragma mark - JSSDK回调方法，本地传递参数给WebView
//
//-(void)loginSuccess;
//-(void)loginCancel;
//-(void)getCarInfoSuccess:(id)obj;
//-(void)getaddressSuccess:(id)obj;
//-(void)paymentSuccess:(id)obj;
//-(void)wechatPaymentSuccess:(id)obj;

@end
