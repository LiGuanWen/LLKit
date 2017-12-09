//
//  LLUtility.h
//  Pods
//
//  Created by Lilong on 2017/6/15.
//
//

#import <Foundation/Foundation.h>

@interface LLUtility : NSObject
/**
 获取当前的NSDate
 */
+ (NSDate *)getNowDateWithFormString:(NSString *)formString;

/**
 比较两个时间段的早晚  两个时间比较大小 time1 和time2 的格式必须为 “YYYY-MM-dd HH:mm:ss”
 如果  time1 > time2 =>NSOrderedDescending
 time1 < time2 =>NSOrderedAscending
 time1 == time2 =>NSOrderedSame
 */
+ (NSComparisonResult)compareTime1:(NSString *)time1 time2:(NSString *)time2;
/**
 date1 和 date2 时间差比较
 // 伪代码
 年差额 = dateCom.year,
 月差额 = dateCom.month,
 日差额 = dateCom.day,
 小时差额 = dateCom.hour,
 分钟差额 = dateCom.minute,
 秒差额 = dateCom.second
 */
+ (NSDateComponents *)componentsDate1:(NSDate *)date1 data2:(NSDate *)date2;
//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format;

//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format;
/**
 获取当前的viewcontroller
 */
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

/**
 提示AlerView
 
 @param currVC 当前的VC
 @param title 标题
 @param message 消息
 @param leftButtomTitle 左边按钮标题
 @param rightButtonTitle 右边按钮标题
 @param leftButtonBlock 右边按钮事件回调
 @param rightButtonBlock 右边按钮事件回调
 */
+ (void)showAlertWithCurrVC:(UIViewController *)currVC title:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtomTitle rightButtonTitle:(NSString *)rightButtonTitle leftButtonBlock:(void (^)(UIAlertAction *  action))leftButtonBlock rightButtonBlock:(void (^)(UIAlertAction *  action))rightButtonBlock;
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
