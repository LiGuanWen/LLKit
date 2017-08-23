//
//  LLBasePageTabBar.m


#import "LLBasePageTabBar.h"

@interface LLBasePageTabBar ()
@property (nonatomic, weak) id<LLBasePageTabBarPrivateDelegate> praviteDelegate;
@end

@implementation LLBasePageTabBar

- (void)clickedPageTabBarAtIndex:(NSInteger)index
{
    if ([_praviteDelegate respondsToSelector:@selector(basePageTabBar:clickedPageTabBarAtIndex:)]) {
        [_praviteDelegate basePageTabBar:self clickedPageTabBarAtIndex:index];
    }
}

- (void)switchToPageIndex:(NSInteger)index
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empLL implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
