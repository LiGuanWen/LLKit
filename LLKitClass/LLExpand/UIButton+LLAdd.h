//
//  UIButton+LLAdd.h
//  AFNetworking
//
//  Created by Lilong on 2017/10/20.
//

#import <UIKit/UIKit.h>

@interface UIButton (LLAdd)
/**
 给按钮绑定事件回调block
 
 @param block 回调的block
 @param controlEvents 回调block的事件
 */
- (void)ll_addEventHandler:(void(^)(void))block forControlEvents:(UIControlEvents)controlEvents;

@end
