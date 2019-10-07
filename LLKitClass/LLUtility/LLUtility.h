//
//  LLUtility.h
//  Pods
//
//  Created by Lilong on 2017/6/15.
//
//

#import <Foundation/Foundation.h>
#import "UICollectionView+RegisterNib.h"
#import "UITableView+RegisterNib.h"
#import "LLDeviceInformation.h"

@interface LLUtility : NSObject

UIViewController * VisibleViewController(void); //与currViewController功能一样
UIViewController * currViewController(void);   //与VisibleViewController功能一样
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC;

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
#pragma mark -- 数组排序方法（升序）
+ (NSArray *)arraySortASC:(NSArray *)array;

#pragma mark -- 数组排序方法（降序）
+ (NSArray *)arraySortDESC:(NSArray *)array;

#pragma mark -- 数组排序方法（乱序）
+ (NSArray *)arraySortBreak:(NSArray *)array;

#pragma mark 正则
//字符串文字的长度
+(CGFloat)widthOfString:(NSString *)string font:(UIFont*)font height:(CGFloat)height;
//字符串文字的高度
+(CGFloat)heightOfString:(NSString *)string font:(UIFont*)font width:(CGFloat)width;
//获取今天的日期：年月日
+(NSDictionary *)getTodayDate;
//邮箱
+ (BOOL) justEmail:(NSString *)email;
//手机号码验证
+ (BOOL) justMobile:(NSString *)mobile;
//车牌号验证
+ (BOOL) justCarNo:(NSString *)carNo;
//车型
+ (BOOL) justCarType:(NSString *)CarType;
//用户名
+ (BOOL) justUserName:(NSString *)name;
//密码
+ (BOOL) justPassword:(NSString *)passWord;
//昵称
+ (BOOL) justNickname:(NSString *)nickname;


@end


