//
//  WebViewController.m
//  PPAutoInsurance
//
//  Created by ang on 15/11/18.
//  Copyright © 2015年 PPChe. All rights reserved.
//

#import "WebViewController.h"
#import "NJKWebViewProgressView.h"
#import <MJRefresh.h>

// JS Bridge
#import "JSBridge.h"
#import "LLHud.h"
#import "YYKit.h"
#import "MJRefreshControl.h"

#define WebViewMessageError @"加载失败"

// WebView Log
#define WEB_VIEW_LOG_ENABLE 0


@interface WebViewController () <NJKWebViewProgressDelegate>


// Web View
@property (nonatomic,strong,readwrite) UIWebView *webView;

// Web Progress View
@property (nonatomic,strong) NJKWebViewProgressView *progressView;

// JSBridge
@property (nonatomic,strong) JSBridge *jsBridge;

@property (assign, nonatomic) BOOL firstLoad;


@end

@implementation WebViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+(WebViewController*)webViewControllerWithURLString:(NSString*)urlString {
    WebViewController *vc = [[WebViewController alloc] init];
    vc.urlString = urlString;
    vc.hidesBottomBarWhenPushed = YES;
    return vc;
}


/**
 *  根据地址初始化Web视图
 *  @return 根据urlString初始化后的Web视图
 */
+(WebViewController*)webViewControllerWithContentString:(NSString*)contentString title:(NSString *)title{
    WebViewController *vc = [[WebViewController alloc] init];
    vc.title = title;
    vc.hidesBottomBarWhenPushed = YES;
    return vc;
}

+ (void)routerWebViewControllerWithURLString:(NSString*)urlString title:(NSString *)title supVC:(UIViewController *)superVC hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed obj:(id)obj shouldShowHud:(BOOL)shouldShowHud{
    WebViewController *vc = [[WebViewController alloc] init];
    vc.urlString = urlString;
    if (title) {
        vc.title = title;
    }
    vc.shouldShowHud = shouldShowHud;
    vc.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed;
    [superVC.navigationController pushViewController:vc animated:YES];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [self.progressView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstLoad = NO;
    // Do any additional setup after loading the view.
    [self initParameters];
    [self loadConfig];
    [self initUI];
    [self addRefreshHeader];
    [self initJSBridge];
    [self loadWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (WEB_VIEW_LOG_ENABLE) {
        NSLog(@"WebView - Should Start Load : %@", request);
    }
    
    // 根据页面的Title自动更新标题
    NSString *webTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (webTitle && ![webTitle isEqualToString:@""]) {
        if (self.shouldAutoChangeTitle == YES) {
            self.navigationItem.title = webTitle;
        }
    }

    NSHTTPURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    if (self.firstLoad == NO)
    {
        self.firstLoad = YES;
        return  YES;
    }
    else
    {
        NSString *url = [NSString stringWithFormat:@"%@",request.URL];
        NSRange range = [url rangeOfString:@"target=_blank"];
        if (range.location != NSNotFound)//不包含
        {
            WebViewController *member = [[WebViewController alloc] init];
            member.urlString = request.URL.absoluteString;
            [self.navigationController pushViewController:member animated:YES];
            return NO;
        }
        //禁止打开AppStore
        NSString *requestedUrl = [[request URL]absoluteString];
        if ([requestedUrl rangeOfString:@"itunes.apple.com"].location == 0)
        {
            return NO;
        }
        return YES;
    }

    
//    // 对于有target=_blank的链接。打开新的VC跳转
//    NSString *url = [NSString stringWithFormat:@"%@",request.URL];
//    NSRange range = [url rangeOfString:@"target=_blank"];
//    // 找到tagert_blank字符串,跳转新的WebViewController
////    
//    if (url && ![url isEqualToString:self.urlString ]) {
//        // 去除target=_blank防止重复跳转
//        url = [url stringByReplacingOccurrencesOfString:@"target=_blank" withString:@""];
//        if (url) {
//            WebViewController *vc = [WebViewController webViewControllerWithURLString:url];
//            if (self.navigationController) {
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//            
//        }
//
//        return NO;
//    }
//    
//    if (range.location != NSNotFound)
//    {
//        // 去除target=_blank防止重复跳转
//        url = [url stringByReplacingOccurrencesOfString:@"target=_blank" withString:@""];
//        if (url) {
//            WebViewController *vc = [WebViewController webViewControllerWithURLString:url];
//            if (self.navigationController) {
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//        }
//    
//        return NO;
//    }else
//    {
//        return YES;
//    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (WEB_VIEW_LOG_ENABLE) {
        NSLog(@"WebView - DidStart Load");
    }
    
    if ([self.navigationItem.title isEqualToString:WebViewMessageError]) {
        self.navigationItem.title = @"";
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (WEB_VIEW_LOG_ENABLE) {
        NSLog(@"WebView - DidFinish Load : %@", webView.request);
    }
    
    if (self.shouldAutoChangeTitle == YES) {
        self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    
    if (self.shouldShowHud == YES) {
        [LLHud hideHUDInView:self.view];
    }
    
    [self.webView.scrollView.mj_header endRefreshing];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nonnull NSError *)error {
    if (WEB_VIEW_LOG_ENABLE) {
        NSLog(@"WebView - DidFail Load With Error : %@", webView.request);
    }
    if (self.shouldAutoChangeTitle == YES) {
        self.navigationItem.title = WebViewMessageError;
    }
    
    if (self.shouldShowHud == YES) {
        [LLHud hideHUDInView:self.view];
    }
    [self.webView.scrollView.mj_header endRefreshing];
}


#pragma mark - Init Methods

- (void)loadConfig {
    // 子类实现配置
}

- (void)addNotificationForReload:(NSArray*)notificationNames {
    for (NSString *notificationName in notificationNames) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadWebView) name:notificationName object:nil];
    }
}

- (void)initParameters {

    
    // 自动更改标题
    self.shouldAutoChangeTitle = YES;
//    //
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:LoginSuccess object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginCancel:) name:LoginCancel object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCarInfoSuccess:) name:CheckedCar object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAddressSuccess:) name:AddAddressSuccess object:nil];
//    // 支付回调
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentSuccess:) name:AliPaymentSuccess object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentSuccess:) name:AliPaymentFail object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPaymentSuccess:) name:WeChatPaymentSuccess object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatPaymentSuccess:) name:WeChatPaymentFail object:nil];

}

- (void)initUI {
    // Init Web View
//    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
//    float navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
//    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-statusBarHeight-navigationBarHeight)];
//    
     self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    if (self.shouldShowHud == YES) {
        [LLHud showHUDInView:self.view title:@"加载中..."];
    }else {
        // Init Progress View
        CGFloat progressBarHeight = 3.f;
        CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
        self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        self.progressView.progressBarView.backgroundColor = [UIColor colorWithRed:0.533 green:0.447 blue:0.325 alpha:1.000];
    }
}

- (void)initJSBridge {
    self.jsBridge = [[JSBridge alloc] init];
    [self.jsBridge addBridgeTo:self.webView controller:self];
}

- (void)loadWebView {
    self.firstLoad = NO;
    if (self.urlString) {
        // 加载目标页
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    }
    if (self.contentString) {
        [self.webView loadHTMLString:self.contentString baseURL:nil];
    }
}

- (void)addRefreshHeader {
    // 下拉刷新
    [MJRefreshControl addRefreshHeaderForScrollView:self.webView.scrollView target:self selector:@selector(loadWebView)];
}

#pragma mark - NJKWebViewProgressDelegate

-(void)webViewProgress:(WebViewJavascriptBridge *)webViewProgress updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:YES];
}


@end
