//
//  LLSlidePageScrollView.h

#import <UIKit/UIKit.h>
#import "LLBasePageTabBar.h"

@class LLSlidePageScrollView;

typedef NS_ENUM(NSUInteger, LLPageTabBarState) {
    LLPageTabBarStateStopOnTop,
    LLPageTabBarStateScrolling,
    LLPageTabBarStateStopOnButtom,
};

@protocol LLSlidePageScrollViewDataSource <NSObject>

@required

// num of pageViews
- (NSInteger)numberOfPageViewOnSlidePageScrollView;

// pageView need inherit UIScrollView (UITableview inherit it) ,and vertical scroll
- (UIScrollView *)slidePageScrollView:(LLSlidePageScrollView *)slidePageScrollView pageVerticalScrollViewForIndex:(NSInteger)index;

@end

@protocol LLSlidePageScrollViewDelegate <NSObject>

@optional

// vertical scroll any offset changes will call
- (void)slidePageScrollView:(LLSlidePageScrollView *)slidePageScrollView verticalScrollViewDidScroll:(UIScrollView *)pageScrollView;

// pageTabBar vertical scroll and state
- (void)slidePageScrollView:(LLSlidePageScrollView *)slidePageScrollView pageTabBarScrollOffset:(CGFloat)offset state:(LLPageTabBarState)state;

// horizen scroll to pageIndex, when index change will call
- (void)slidePageScrollView:(LLSlidePageScrollView *)slidePageScrollView horizenScrollToPageIndex:(NSInteger)index;

// horizen scroll any offset changes will call
- (void)slidePageScrollView:(LLSlidePageScrollView *)slidePageScrollView horizenScrollViewDidScroll:(UIScrollView *)scrollView;

// horizen scroll Begin Dragging
- (void)slidePageScrollView:(LLSlidePageScrollView *)slidePageScrollView horizenScrollViewWillBeginDragging:(UIScrollView *)scrollView;

// horizen scroll called when scroll view grinds to a halt
- (void)slidePageScrollView:(LLSlidePageScrollView *)slidePageScrollView horizenScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

@interface LLSlidePageScrollView : UIView

@property (nonatomic, weak)   id<LLSlidePageScrollViewDataSource> dataSource;
@property (nonatomic, weak)   id<LLSlidePageScrollViewDelegate> delegate;

@property (nonatomic, assign) BOOL automaticallyAdjustsScrollViewInsets; // default NO;(iOS 7) it will setup viewController automaticallyAdjustsScrollViewInsets, because this properLL (YES) cause scrollView layout no correct

/**
 header区域是否可以上下滑动 (手势 开启与关闭)
 */
@property (nonatomic, assign) BOOL headerViewScrollEnable; // default YES， header let to veritical scroll (header区域是否可以上下滑动)

@property (nonatomic, strong) UIView *headerView; // defult nil，don't forget set height
/**
 设置headerView 是否可以下拉 跟随变大  默认可以 = NO;
 */
@property (nonatomic, assign) BOOL parallaxHeaderEffect; // def NO, Parallax effect (弹性视差效果)

@property (nonatomic, strong) LLBasePageTabBar *pageTabBar; //defult nil

/**
 设置 是否需要在tabbar到顶部的时候停止滚动 改为子类滚动
 */
@property (nonatomic, assign) BOOL pageTabBarIsStopOnTop;  // default YES, is stop on top

/**
 tabbar到顶部的时候停止滚动 的高度
 */
@property (nonatomic, assign) CGFloat pageTabBarStopOnTopHeight; // default 0, bageTabBar stop on top height, if pageTabBarIsStopOnTop is NO ,this properLL is inValid

@property (nonatomic, strong) UIView *footerView; // defult nil

/**
 显示哪一个子类
 */
@property (nonatomic, assign, readonly) NSInteger curPageIndex; // defult 0

// 当滚动到scroll宽度的百分之多少 改变index 
@property (nonatomic, assign) CGFloat changeToNextIndexWhenScrollToWidthOfPercent; // 0.0~0.1 default 0.5, when scroll to half of width, change to next index


- (void)reloadData;

- (void)scrollToPageIndex:(NSInteger)index animated:(BOOL)animated;

- (UIScrollView *)pageScrollViewForIndex:(NSInteger)index;

- (NSInteger)indexOfPageScrollView:(UIScrollView *)pageScrollView;

@end
