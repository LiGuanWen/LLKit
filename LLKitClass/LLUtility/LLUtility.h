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
//自定义 正则匹配
+ (BOOL) justWithInitRegularly:(NSString *)Regularly Str:(NSString *)str;
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
//身份证号
+ (BOOL) justIdentityCard: (NSString *)identityCard;
//汉字
+ (BOOL) justChineseCharacter:(NSString *)Chinese;
//网址Url
+ (BOOL) justURlSite:(NSString *)urlSite;
//IP
+ (BOOL) justIP:(NSString *)ip;
//匹配流量ID
+ (BOOL) justFromID:(NSString *)fid;

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
