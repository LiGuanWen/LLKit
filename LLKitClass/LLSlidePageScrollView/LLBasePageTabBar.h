//
//  LLBasePageTabBar.h


#import <UIKit/UIKit.h>

@class LLBasePageTabBar;
@protocol LLBasePageTabBarPrivateDelegate <NSObject>

- (void)basePageTabBar:(LLBasePageTabBar *)basePageTabBar clickedPageTabBarAtIndex:(NSInteger)index;

@end

// base class ,Fully customizable pageTabBar inherit it
@interface LLBasePageTabBar : UIView

// when clicked pageTabBar index, must /*Ourself*/ call this, to change LLSlidePageScrollView index
- (void)clickedPageTabBarAtIndex:(NSInteger)index;

// override, auto call ,when LLSlidePageScrollView index change, you can change your pageTabBar index on this method
- (void)switchToPageIndex:(NSInteger)index;

@end
