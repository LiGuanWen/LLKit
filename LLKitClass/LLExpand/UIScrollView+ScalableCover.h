
#import <UIKit/UIKit.h>

@interface ScalableCover : UIImageView
@property (assign, nonatomic) CGRect initFrame;

@property (nonatomic, strong) UIScrollView *scrollView;

@end




@interface UIScrollView (ScalableCover)

@property (nonatomic, weak) ScalableCover *scalableCover;
//#warning 该行代码添加下拉缩放图
//[self.tableView addScalableCoverWithImage:[UIImage imageNamed:@"mebg"] initFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];


- (void)addScalableCoverWithImage:(UIImage *)image initFrame:(CGRect)initFrame;

- (void)removeScalableCover;

@end

