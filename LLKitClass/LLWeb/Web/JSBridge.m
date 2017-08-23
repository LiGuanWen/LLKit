//
//  PPJSBridge.m
//  PPAutoInsurance
//
//  Created by ang on 15/11/18.
//  Copyright © 2015年 PPChe. All rights reserved.
//

#import "JSBridge.h"


// Main

//// 百度地图
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>
//#import "PPCBaiduWeb.h"
//#import <CoreLocation/CoreLocation.h>



@interface JSBridge ()

@property (nonatomic,weak) WebViewController *curWebViewController;
// JS Bridge
@property (nonatomic,strong) WebViewJavascriptBridge* bridge;

@property (nonatomic,strong) NSMutableArray *handlerNames;

// 定位用
//@property (nonatomic,strong) BMKLocationService *locationService;

@end

@implementation JSBridge

- (void)dealloc
{
//    self.locationService.delegate = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.handlerNames = [NSMutableArray array];
    }
    return self;
}

- (void)addBridgeTo:(UIWebView*)webView controller:(WebViewController*)webViewController {
    self.curWebViewController = webViewController;
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webView webViewDelegate:webViewController handler:^(id data, WVJBResponseCallback responseCallback) {
            responseCallback(@"Right back atcha");
    }];
    self.bridge.progressDelegate = (id)webViewController;
    
    // 添加JS处理方法
    [self addHandlers];
}

- (void)addHandlers {

}


@end
