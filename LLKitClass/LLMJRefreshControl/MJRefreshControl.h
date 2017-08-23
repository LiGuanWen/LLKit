//
//  PPRefreshControl.h
//  PPAutoInsurance
//
//  Created by ang on 16/1/22.
//  Copyright © 2016年 PPChe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"

@interface MJRefreshControl : NSObject

+ (void)addRefreshHeaderForScrollView:(UIScrollView*)scrollView target:(id)target selector:(SEL)reloadSelector;

+ (void)addRefreshHeaderForTableView:(UITableView*)tableView target:(id)target;

+ (void)addRefreshHeaderForTableView:(UITableView*)tableView target:(id)target selector:(SEL)reloadSelector;

+ (void)addRefreshFooterForTableView:(UITableView*)tableView target:(id)target selector:(SEL)loadMoreSelector;


@end
