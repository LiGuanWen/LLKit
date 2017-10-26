//
//  UIButton+LLAdd.m
//  AFNetworking
//
//  Created by Lilong on 2017/10/20.
//

#import "UIButton+LLAdd.h"
#import <objc/runtime.h>

typedef void(^LL_ButtonEventsBlock)(void);

@interface UIButton ()

/** 事件回调的block */
@property (nonatomic, copy) LL_ButtonEventsBlock ll_buttonEventsBlock;

@end
@implementation UIButton (LLAdd)


#pragma mark  添加属性
static void *ll_buttonEventsBlockKey = &ll_buttonEventsBlockKey;

- (LL_ButtonEventsBlock)ll_buttonEventsBlock {
    return objc_getAssociatedObject(self, &ll_buttonEventsBlockKey);
}

- (void)setLl_buttonEventsBlock:(LL_ButtonEventsBlock)ll_buttonEventsBlock{
    objc_setAssociatedObject(self, &ll_buttonEventsBlockKey, ll_buttonEventsBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark 方法实现
/**
 给按钮绑定事件回调block
 
 @param block 回调的block
 @param controlEvents 回调block的事件
 */
- (void)ll_addEventHandler:(void (^)(void))block forControlEvents:(UIControlEvents)controlEvents {
    self.ll_buttonEventsBlock = block;
    [self addTarget:self action:@selector(ll_blcokButtonClicked) forControlEvents:controlEvents];
}

// 按钮点击
- (void)ll_blcokButtonClicked {
    !self.ll_buttonEventsBlock ?: self.ll_buttonEventsBlock();
}
@end
