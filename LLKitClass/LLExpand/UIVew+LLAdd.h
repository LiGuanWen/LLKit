//
//  UIVew+LLAdd.h
//  AFNetworking
//
//  Created by Lilong on 2017/10/20.
//
#import <UIKit/UIKit.h>

@interface UIView (LLAdd)
/**
 与单击手势绑定的block
 
 @param clickTappedBlock 单击手势事件回调的block
 */
- (void)ll_clickTapped:(void(^)(void))clickTappedBlock;
@end
