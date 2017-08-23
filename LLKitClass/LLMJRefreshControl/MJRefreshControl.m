//
//  PPRefreshControl.m
//  PPAutoInsurance
//
//  Created by ang on 16/1/22.
//  Copyright © 2016年 PPChe. All rights reserved.
//

#import "MJRefreshControl.h"


@implementation MJRefreshControl

+ (void)addRefreshHeaderForScrollView:(UIScrollView*)scrollView target:(id)target selector:(SEL)reloadSelector {
    // 设置回调
    MJRefreshGifHeader *gifHeader =  [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:reloadSelector];
    scrollView.mj_header = gifHeader;
    // 隐藏时间
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    gifHeader.stateLabel.hidden = YES;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu", (unsigned long)i]];
        [idleImages addObject:image];
    }
    [gifHeader setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *headerRefreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu", (unsigned long)i]];
        [headerRefreshingImages addObject:image];
    }
    
    [gifHeader setImages:headerRefreshingImages forState:MJRefreshStateRefreshing];
}

+ (void)addRefreshHeaderForTableView:(UITableView*)tableView target:target {
    // 设置回调
    SEL selector = NSSelectorFromString(@"getData");
    
    [MJRefreshControl addRefreshHeaderForTableView:tableView target:target selector:selector];
}


+ (void)addRefreshHeaderForTableView:(UITableView*)tableView target:(id)target selector:(SEL)reloadSelector {
    // 设置回调
    MJRefreshGifHeader *gifHeader =  [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:reloadSelector];
    tableView.mj_header = gifHeader;
    // 隐藏时间
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    gifHeader.stateLabel.hidden = YES;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=12; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu", (unsigned long)i]];
        [idleImages addObject:image];
    }
    [gifHeader setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *headerRefreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=12; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu", (unsigned long)i]];
        [headerRefreshingImages addObject:image];
    }
    
    [gifHeader setImages:headerRefreshingImages forState:MJRefreshStateRefreshing];
}

+ (void)addRefreshFooterForTableView:(UITableView*)tableView target:(id)target selector:(SEL)loadMoreSelector {
    // 设置回调
    MJRefreshAutoGifFooter *gifFooter =  [MJRefreshAutoGifFooter footerWithRefreshingTarget:target refreshingAction:loadMoreSelector];
    tableView.mj_footer = gifFooter;
    
    // 隐藏状态
    gifFooter.stateLabel.hidden = YES;
    gifFooter.stateLabel.textColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    gifFooter.refreshingTitleHidden = YES;
    
    // 设置正在刷新状态的动画图片s
    NSMutableArray *footerRefreshingImages = [NSMutableArray array];
    
    for (NSUInteger i = 1; i<=12; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu", (unsigned long)i]];
        [footerRefreshingImages addObject:image];
    }
    [gifFooter setImages:footerRefreshingImages forState:MJRefreshStateRefreshing];
}

@end
