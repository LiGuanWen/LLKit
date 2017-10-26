//
//  UIVew+LLAdd.m
//  AFNetworking
//
//  Created by Lilong on 2017/10/20.
//

#import "UIVew+LLAdd.h"
#import <objc/runtime.h>

typedef void(^LL_ViewTappedBlock)(void);

@interface UIView ()

/** 单击手势事件回调的block */
@property (nonatomic, copy) LL_ViewTappedBlock ll_viewTappedBlock;

@end

@implementation UIView (LLAdd)

#pragma mark 添加属性

static void *ll_viewTappedBlockKey = &ll_viewTappedBlockKey;

- (LL_ViewTappedBlock)ll_viewTappedBlock {
    return objc_getAssociatedObject(self, &ll_viewTappedBlockKey);
}

- (void)setLl_viewTappedBlock:(LL_ViewTappedBlock)ll_viewTappedBlock {
    objc_setAssociatedObject(self, &ll_viewTappedBlockKey, ll_viewTappedBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark 方法实现
/**
 与单击手势绑定的block
 
 @param clickTappedBlock 单击手势事件回调的block
 */
- (void)ll_clickTapped:(void(^)(void))clickTappedBlock {
    self.ll_viewTappedBlock = clickTappedBlock;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    [self addGestureRecognizer:tapGesture];
}

// 单击view
- (void)viewTapped {
    if (self.ll_viewTappedBlock) {
        self.ll_viewTappedBlock();
    }
}
@end
