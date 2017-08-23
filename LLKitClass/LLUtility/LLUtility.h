//
//  LLUtility.h
//  Pods
//
//  Created by Lilong on 2017/6/15.
//
//

#import <Foundation/Foundation.h>

@interface LLUtility : NSObject

UIViewController * VisibleViewController();

/**
 加载 Xib 文件
 
 @param nibName  Nib 名称
 
 @return instance
 */
+ (id)loadNibWithNibName:(NSString *)nibName;

/**
 提示AlerView
 
 @param title 标题
 @param message 消息
 @param leftButtomTitle 左边按钮标题
 @param rightButtonTitle 右边按钮标题
 @param leftButtonBlock 右边按钮事件回调
 @param rightButtonBlock 右边按钮事件回调
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtomTitle rightButtonTitle:(NSString *)rightButtonTitle leftButtonBlock:(void (^)(UIAlertAction *  action))leftButtonBlock rightButtonBlock:(void (^)(UIAlertAction *  action))rightButtonBlock;
@end

#pragma mark - UITableView category

@interface UITableView (RegisterNib)

- (void)registerCellNibWithNibName:(NSString *) nibName;
- (void)registerCellClassWithClassName:(NSString *) className;
- (void)multiRegisterCellNibsWithNibNames:(NSArray *) nibNames;

@end

#pragma mark - UICollectionView category

@interface UICollectionView (RegisterNib)

- (void)registerCellNibWithNibName:(NSString *) nibName;
- (void)registerCellClassWithClassName:(NSString *) className;
- (void)multiRegisterCellNibsWithNibNames:(NSArray *) nibNames;

@end
