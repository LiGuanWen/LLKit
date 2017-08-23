//
//  LLSlidePageScrollViewController.h


#import <UIKit/UIKit.h>
#import "LLSlidePageScrollView.h"

@protocol LLDisplayPageScrollViewDelegate <NSObject>

// you should implement the method, because I don't know the view you want to display
// the view need inherit UIScrollView (UITableview inherit it) ,also vertical scroll 
- (UIScrollView *)displayPageScrollView;

@end

@interface LLSlidePageScrollViewController : UIViewController<LLSlidePageScrollViewDelegate,LLSlidePageScrollViewDataSource>

@property (nonatomic, weak, readonly) LLSlidePageScrollView *slidePageScrollView;

// the viewController need conform to LLDisplayScrollViewDelegate
@property (nonatomic, strong) NSArray   *viewControllers;
@end
