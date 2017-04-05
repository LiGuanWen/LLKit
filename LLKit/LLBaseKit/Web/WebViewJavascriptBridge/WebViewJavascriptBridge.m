//
//  WebViewJavascriptBridge.m
//  ExampleApp-iOS
//
//  Created by Marcus Westin on 6/14/13.
//  Copyright (c) 2013 Marcus Westin. All rights reserved.
//

#import "WebViewJavascriptBridge.h"

#if __has_feature(objc_arc_weak)
    #define WVJB_WEAK __weak
#else
    #define WVJB_WEAK __unsafe_unretained
#endif


NSString *completeRPCURLPath = @"/njkwebviewprogressproxy/complete";

const float NJKInitialProgressValue = 0.2f;
const float NJKInteractiveProgressValue = 0.5f;
const float NJKFinalProgressValue = 0.9f;


@implementation WebViewJavascriptBridge {
    WVJB_WEAK WVJB_WEBVIEW_TYPE* _webView;
    WVJB_WEAK id _webViewDelegate;
    long _uniqueId;
    WebViewJavascriptBridgeBase *_base;
#if defined WVJB_PLATFORM_IOS
    NSUInteger _numRequestsLoading;
#endif
    
    // NJ
    NSUInteger _loadingCount;
    NSUInteger _maxLoadCount;
    NSURL *_currentURL;
    BOOL _interactive;

}

/* API
 *****/

+ (void)enableLogging { [WebViewJavascriptBridgeBase enableLogging]; }

+ (instancetype)bridgeForWebView:(WVJB_WEBVIEW_TYPE*)webView handler:(WVJBHandler)handler {
    return [self bridgeForWebView:webView webViewDelegate:nil handler:handler];
}

+ (instancetype)bridgeForWebView:(WVJB_WEBVIEW_TYPE*)webView webViewDelegate:(WVJB_WEBVIEW_DELEGATE_TYPE*)webViewDelegate handler:(WVJBHandler)messageHandler {
    return [self bridgeForWebView:webView webViewDelegate:webViewDelegate handler:messageHandler resourceBundle:nil];
}

+ (instancetype)bridgeForWebView:(WVJB_WEBVIEW_TYPE*)webView webViewDelegate:(WVJB_WEBVIEW_DELEGATE_TYPE*)webViewDelegate handler:(WVJBHandler)messageHandler resourceBundle:(NSBundle*)bundle
{
    WebViewJavascriptBridge* bridge = [[WebViewJavascriptBridge alloc] init];
    [bridge _platformSpecificSetup:webView webViewDelegate:webViewDelegate handler:messageHandler resourceBundle:bundle];
    return bridge;
}

- (void)send:(id)data {
    [self send:data responseCallback:nil];
}

- (void)send:(id)data responseCallback:(WVJBResponseCallback)responseCallback {
    [_base sendData:data responseCallback:responseCallback handlerName:nil];
}

- (void)callHandler:(NSString *)handlerName {
    [self callHandler:handlerName data:nil responseCallback:nil];
}

- (void)callHandler:(NSString *)handlerName data:(id)data {
    [self callHandler:handlerName data:data responseCallback:nil];
}

- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback {
    [_base sendData:data responseCallback:responseCallback handlerName:handlerName];
}

- (void)registerHandler:(NSString *)handlerName handler:(WVJBHandler)handler {
    _base.messageHandlers[handlerName] = [handler copy];
}

- (void)callResponseCallback:(NSString *)handlerName data:(id)data {
    WVJBResponseCallback responseCallback = _base.JSresponseCallbacks[handlerName];
    if (responseCallback != NULL) {
        responseCallback (data);
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _maxLoadCount = _loadingCount = 0;
        _interactive = NO;
    }
    return self;
}

/* Platform agnostic internals
 *****************************/

- (void)dealloc {
    [self _platformSpecificDealloc];
    _base = nil;
    _webView = nil;
    _webViewDelegate = nil;
}

- (NSString*) _evaluateJavascript:(NSString*)javascriptCommand
{
    return [_webView stringByEvaluatingJavaScriptFromString:javascriptCommand];
}

/* Platform specific internals: OSX
 **********************************/
#if defined WVJB_PLATFORM_OSX

- (void) _platformSpecificSetup:(WVJB_WEBVIEW_TYPE*)webView webViewDelegate:(WVJB_WEBVIEW_DELEGATE_TYPE*)webViewDelegate handler:(WVJBHandler)messageHandler resourceBundle:(NSBundle*)bundle{
    _webView = webView;
    _webViewDelegate = webViewDelegate;
    
    _webView.frameLoadDelegate = self;
    _webView.resourceLoadDelegate = self;
    _webView.policyDelegate = self;
    
    _base = [[WebViewJavascriptBridgeBase alloc] initWithHandler:(WVJBHandler)messageHandler resourceBundle:(NSBundle*)bundle];
    _base.delegate = self;
}

- (void) _platformSpecificDealloc {
    _webView.frameLoadDelegate = nil;
    _webView.resourceLoadDelegate = nil;
    _webView.policyDelegate = nil;
}

- (void)webView:(WebView *)webView didFinishLoadForFrame:(WebFrame *)frame
{
    if (webView != _webView) { return; }
    
    if (![[webView stringByEvaluatingJavaScriptFromString:[_base webViewJavascriptCheckCommand]] isEqualToString:@"true"]) {
        [_base injectJavascriptFile:YES];
    }
    
    [_base dispatchStartUpMessageQueue];
    
    if (_webViewDelegate && [_webViewDelegate respondsToSelector:@selector(webView:didFinishLoadForFrame:)]) {
        [_webViewDelegate webView:webView didFinishLoadForFrame:frame];
    }
}

- (void)webView:(WebView *)webView didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame {
    if (webView != _webView) { return; }
    
    if (_webViewDelegate && [_webViewDelegate respondsToSelector:@selector(webView:didFailLoadWithError:forFrame:)]) {
        [_webViewDelegate webView:webView didFailLoadWithError:error forFrame:frame];
    }
}

- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id<WebPolicyDecisionListener>)listener
{
    if (webView != _webView) { return; }
    
    NSURL *url = [request URL];
    if ([_base isCorrectProcotocolScheme:url]) {
        if ([_base isCorrectHost:url]) {
            NSString *messageQueueString = [self _evaluateJavascript:[_base webViewJavascriptFetchQueyCommand]];
            [_base flushMessageQueue:messageQueueString];
        } else {
            [_base logUnkownMessage:url];
        }
        [listener ignore];
    } else if (_webViewDelegate && [_webViewDelegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:request:frame:decisionListener:)]) {
        [_webViewDelegate webView:webView decidePolicyForNavigationAction:actionInformation request:request frame:frame decisionListener:listener];
    } else {
        [listener use];
    }
}

- (void)webView:(WebView *)webView didCommitLoadForFrame:(WebFrame *)frame {
    if (webView != _webView) { return; }
    
    if (_webViewDelegate && [_webViewDelegate respondsToSelector:@selector(webView:didCommitLoadForFrame:)]) {
        [_webViewDelegate webView:webView didCommitLoadForFrame:frame];
    }
}

- (NSURLRequest *)webView:(WebView *)webView resource:(id)identifier willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(WebDataSource *)dataSource {
    if (webView != _webView) { return request; }
    
    if (_webViewDelegate && [_webViewDelegate respondsToSelector:@selector(webView:resource:willSendRequest:redirectResponse:fromDataSource:)]) {
        return [_webViewDelegate webView:webView resource:identifier willSendRequest:request redirectResponse:redirectResponse fromDataSource:dataSource];
    }
    
    return request;
}



/* Platform specific internals: iOS
 **********************************/
#elif defined WVJB_PLATFORM_IOS

- (void) _platformSpecificSetup:(WVJB_WEBVIEW_TYPE*)webView webViewDelegate:(id<UIWebViewDelegate>)webViewDelegate handler:(WVJBHandler)messageHandler resourceBundle:(NSBundle*)bundle{
    _webView = webView;
    _webView.delegate = self;
    _webViewDelegate = webViewDelegate;
    _base = [[WebViewJavascriptBridgeBase alloc] initWithHandler:(WVJBHandler)messageHandler resourceBundle:(NSBundle*)bundle];
    _base.delegate = self;
}

- (void) _platformSpecificDealloc {
    _webView.delegate = nil;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self js_webViewDidFinishLoad:webView];
    [self nj_webViewDidFinishLoad:webView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self js_webView:webView didFailLoadWithError:error];
    [self nj_webView:webView didFailLoadWithError:error];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return [self js_webView:webView shouldStartLoadWithRequest:request navigationType:navigationType] &&
    [self nj_webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self js_webViewDidStartLoad:webView];
    [self nj_webViewDidStartLoad:webView];
}

// Bridge

- (void)js_webViewDidFinishLoad:(UIWebView *)webView {
    if (webView != _webView) { return; }
    
    _numRequestsLoading--;
    
    if (_numRequestsLoading == 0 && ![[webView stringByEvaluatingJavaScriptFromString:[_base webViewJavascriptCheckCommand]] isEqualToString:@"true"]) {
        [_base injectJavascriptFile:YES];
    }
    [_base dispatchStartUpMessageQueue];
    
    
    __strong WVJB_WEBVIEW_DELEGATE_TYPE* strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [strongDelegate webViewDidFinishLoad:webView];
    }
}

- (void)js_webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (webView != _webView) { return; }
    
    _numRequestsLoading--;
    
    __strong WVJB_WEBVIEW_DELEGATE_TYPE* strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [strongDelegate webView:webView didFailLoadWithError:error];
    }
}

- (BOOL)js_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (webView != _webView) { return YES; }
    
    NSURL *url = [request URL];
    __strong WVJB_WEBVIEW_DELEGATE_TYPE* strongDelegate = _webViewDelegate;
    if ([_base isCorrectProcotocolScheme:url]) {
        if ([_base isCorrectHost:url]) {
            NSString *messageQueueString = [self _evaluateJavascript:[_base webViewJavascriptFetchQueyCommand]];
            [_base flushMessageQueue:messageQueueString];
        } else {
            [_base logUnkownMessage:url];
        }
        return NO;
    } else if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [strongDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    } else {
        return YES;
    }
}

- (void)js_webViewDidStartLoad:(UIWebView *)webView {
    if (webView != _webView) { return; }
    
    _numRequestsLoading++;
    
    __strong WVJB_WEBVIEW_DELEGATE_TYPE* strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [strongDelegate webViewDidStartLoad:webView];
    }
}


#endif

// NJ

- (void)startProgress
{
    if (_progress < NJKInitialProgressValue) {
        [self setProgress:NJKInitialProgressValue];
    }
}

- (void)incrementProgress
{
    float progress = self.progress;
    float maxProgress = _interactive ? NJKFinalProgressValue : NJKInteractiveProgressValue;
    float remainPercent = (float)_loadingCount / (float)_maxLoadCount;
    float increment = (maxProgress - progress) * remainPercent;
    progress += increment;
    progress = fmin(progress, maxProgress);
    [self setProgress:progress];
}

- (void)completeProgress
{
    [self setProgress:1.0];
}

- (void)setProgress:(float)progress
{
    // progress should be incremental only
    if (progress > _progress || progress == 0) {
        _progress = progress;
        if ([_progressDelegate respondsToSelector:@selector(webViewProgress:updateProgress:)]) {
            [_progressDelegate webViewProgress:self updateProgress:progress];
        }
        if (_progressBlock) {
            _progressBlock(progress);
        }
    }
}

- (void)reset
{
    _maxLoadCount = _loadingCount = 0;
    _interactive = NO;
    [self setProgress:0.0];
}


#pragma mark -
#pragma mark NJUIWebViewDelegate

- (BOOL)nj_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.path isEqualToString:completeRPCURLPath]) {
        [self completeProgress];
        return NO;
    }
    
    BOOL ret = YES;
    
    BOOL isFragmentJump = NO;
    if (request.URL.fragment) {
        NSString *nonFragmentURL = [request.URL.absoluteString stringByReplacingOccurrencesOfString:[@"#" stringByAppendingString:request.URL.fragment] withString:@""];
        isFragmentJump = [nonFragmentURL isEqualToString:webView.request.URL.absoluteString];
    }
    
    BOOL isTopLevelNavigation = [request.mainDocumentURL isEqual:request.URL];
    
    BOOL isHTTPOrLocalFile = [request.URL.scheme isEqualToString:@"http"] || [request.URL.scheme isEqualToString:@"https"] || [request.URL.scheme isEqualToString:@"file"];
    if (ret && !isFragmentJump && isHTTPOrLocalFile && isTopLevelNavigation) {
        _currentURL = request.URL;
        [self reset];
    }
    return ret;
}

- (void)nj_webViewDidStartLoad:(UIWebView *)webView
{

    _loadingCount++;
    _maxLoadCount = fmax(_maxLoadCount, _loadingCount);
    
    [self startProgress];
}

- (void)nj_webViewDidFinishLoad:(UIWebView *)webView
{

    _loadingCount--;
    [self incrementProgress];
    
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive) {
        _interactive = YES;
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request.mainDocumentURL.scheme, webView.request.mainDocumentURL.host, completeRPCURLPath];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    
    BOOL isNotRedirect = _currentURL && [_currentURL isEqual:webView.request.mainDocumentURL];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if (complete && isNotRedirect) {
        [self completeProgress];
    }
}

- (void)nj_webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    _loadingCount--;
    [self incrementProgress];
    
    NSString *readyState = [webView stringByEvaluatingJavaScriptFromString:@"document.readyState"];
    
    BOOL interactive = [readyState isEqualToString:@"interactive"];
    if (interactive) {
        _interactive = YES;
        NSString *waitForCompleteJS = [NSString stringWithFormat:@"window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request.mainDocumentURL.scheme, webView.request.mainDocumentURL.host, completeRPCURLPath];
        [webView stringByEvaluatingJavaScriptFromString:waitForCompleteJS];
    }
    
    BOOL isNotRedirect = _currentURL && [_currentURL isEqual:webView.request.mainDocumentURL];
    BOOL complete = [readyState isEqualToString:@"complete"];
    if ((complete && isNotRedirect) || error) {
        [self completeProgress];
    }
}

@end
