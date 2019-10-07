//
//  UIButton+LLImageTitleSpacing.h
//  Pods
//
//

#import <UIKit/UIKit.h>

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, LLButtonEdgeInsetsStyle) {
    LLButtonEdgeInsetsStyleTop,     ///< image在上，label在下
    LLButtonEdgeInsetsStyleLeft,    ///< image在左，label在右
    LLButtonEdgeInsetsStyleBottom,  ///< image在下，label在上
    LLButtonEdgeInsetsStyleRight    ///< image在右，label在左
};

@interface UIButton (LLImageTitleSpacing)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(LLButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
