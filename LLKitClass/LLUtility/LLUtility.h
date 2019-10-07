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
/**
 是否是iPhoneX 系列
 */
+ (BOOL)isIPhoneXSeries;

/**
 现在的Unix时间戳
 */
+ (NSString *)unixTimestamp;
/**
 //判断中英混合的的字符串长度 英文1 中文2
 */
+ (int)convertToInt:(NSString*)strtemp;

/**
 * @brief 将NSDate对象转换为字符串,需带格式化符号
 */
+ (NSString *)tansformTime:(NSDate *)date DateFormat:(NSString *)dateFormat;

/**
 * @brief 将NSDate对象转换为字符串,格式化符号  yyyy-MM-dd
 */
+ (NSString *) convertNSStringWithDate:(NSDate *)date;

/**
 * @brief 将字符串转换为NSDate对象
 */
+ (NSDate *)convertNSDateWithString:(NSString *) dateString DateFormat:(NSString *)dateFormat;

/**
 *  将NSDate转换成字符串（几分钟以前）
 */
+ (NSString *)converNsstringWithDateAgo:(NSDate *)date;
/**
 *   十六进制color转为UIColor  and alpha
 */
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert alpha:(CGFloat)alpha;

/**
 *获取屏幕截屏
 */
+ (UIImage *)getScreenshot;
/**
 * 计算字符串 size
 */
+ (CGSize)stringSizeWithString:(NSString*)string Font:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *获取视频时间
 */
+ (NSString *)getVideoTime:(NSInteger)videoTime;
/**
 收取视频首帧
 */
+ (UIImage *)thumbnailImageRequest:(NSURL *)videoUrl;

/**
 * 将颜色转换成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)imageSize;

/**
 使用 创建自定义名称的相册 并获取自定义到自定义相册
 
 @param name 相册名称  如果没有 则使用APP的名称
 */
+ (void)createAlbumInPhoneAlbumWithName:(NSString *__nullable)name;

//保存视频或者图片到 相册 -
+ (void)saveImage:(UIImage *__nullable)image video:(NSString *__nullable)video customAlbumName:(NSString *)customAlbumName;
//保存视频或者图片到 相册 -
+ (void)saveToAlbumWithMetadata:(NSDictionary *__nullable)metadata
                      imageData:(NSData *__nullable)imageData
                      videoData:(NSString *__nullable)videoData
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;

//指定宽度按比例缩放
+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
//按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;


/**
 提示AlerView
 
 @param title 标题
 @param message 消息
 @param leftButtomTitle 左边按钮标题
 @param rightButtonTitle 右边按钮标题
 @param leftButtonBlock 右边按钮事件回调
 @param rightButtonBlock 右边按钮事件回调
 */
+ (void)showAlertWithCurVC:(UIViewController *)curVC title:(NSString *__nullable)title message:(NSString *__nullable)message leftButtonTitle:(NSString *__nullable)leftButtomTitle rightButtonTitle:(NSString *__nullable)rightButtonTitle leftButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action))leftButtonBlock rightButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action))rightButtonBlock;

/**
 show alert 带 TextField
 
 @param curVC 当前
 @param title 标题
 @param defluteStr 默认文本
 @param placeholder 提示
 @param leftButtomTitle 左边按钮文案
 @param rightButtonTitle 右边按钮文案
 @param leftButtonBlock 左边点击事件回调
 @param rightButtonBlock 右边的j点击事件回调
 */
+ (void)showAlertTextFieldWithCurVC:(UIViewController *)curVC title:(NSString *__nullable)title  defluteStr:(NSString *__nullable)defluteStr placeholderStr:(NSString *__nullable)placeholder  leftButtonTitle:(NSString *__nullable)leftButtomTitle rightButtonTitle:(NSString *__nullable)rightButtonTitle leftButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action,NSString *inputStr))leftButtonBlock rightButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action,NSString *inputStr))rightButtonBlock;

/**
 提示SheetView
 
 @param title 标题
 @param message 消息
 */
+ (void)showSheetWithCurVC:(UIViewController *)curVC title:(NSString *__nullable)title message:(NSString *__nullable)message firstButtonTitle:(NSString *__nullable)firstButtonTitle secondButtonTitle:(NSString *__nullable)secondButtonTitle thirdButtonTitle:(NSString *__nullable)thirdButtonTitle firstButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action))firstButtonBlock secondButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action))secondButtonBlock thirdButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action))thirdButtonBlock;


/**
 识别脸部
 
 @param image 图片
 @return 如果有显示脸部 = YES
 */
+ (BOOL)checkImagefineFaceWithImage:(UIImage *)image;
///生成随机字符串 数字+字母 length 长度
+ (NSString *)randomStringWithLength:(int)length;
///生成随机字符串 数字 length 长度
+ (NSString *)randomStringNumberWithLength:(int)length;
///生成字母随机字符串 length 长度
+ (NSString *)randomStringLetterWithLength:(int)length;

//有没有设置代理
+ (BOOL)checkProxySetting;
//view 转图片
+ (UIImage *)snapsHotView:(UIView *)view;
//html 转 NSAttributedString 不是很准确
+ (NSAttributedString *)attributeStrWithHtml:(NSString *)html;
///判断字符串是否为浮点数
+ (BOOL)isPureFloat:(NSString*)string;
///判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string;
/**
 tableView滑到最底部
 */
+ (void)scrollTableToFoot:(BOOL)animated tableView:(UITableView *)tableView;

/**
 @param colors 颜色数组
 @param gradientType 样式
 gradientType = 0,//从上到下
 gradientType = 1,//从左到右
 gradientType = 2,//左上到右下
 gradientType = 3,//右上到左下
 @param imgSize 图片大小
 @return 图片
 */
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors
                             gradientType:(NSInteger)gradientType
                                  imgSize:(CGSize)imgSize;

/**
 获取url host 头部
 */
+ (NSString *)hostStringWithUrlString:(NSString *)urlStr;

/**
 获取url 携带的参数
 */
+ (NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr;

/**
 输入数字时一些限制
 @param limitZero 首输是否限制输0
 @param NumberDecimalPoints 小数点后位数
 */
+ (BOOL)inputLimitTextField:(UITextField *)textField
                      range:(NSRange)range
                     string:(NSString *)string
                  limitZero:(BOOL)limitZero NumberDecimalPoints:(NSInteger)NumberDecimalPoints;

/**
 字数限制截断
 */
+ (void)spaceConstraintsLimitString:(UITextField *)Textfield
                       limitMaxWord:(NSInteger)limitMaxWord;
/**
 @param limitMaxWord 限制最大数
 */
+ (BOOL)spaceConstraintsLimit:(NSString *)TextString
                 limitMaxWord:(NSInteger)limitMaxWord
                  waringBlock:(void (^_Nullable)(NSString *hint))waringBlock;
@end


