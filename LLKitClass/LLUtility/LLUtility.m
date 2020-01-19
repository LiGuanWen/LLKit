
//
//  LLUtility.m
//  Pods
//
//  Created by Lilong on 2017/6/15.
//
//

#import "LLUtility.h"
#import <AssetsLibrary/AssetsLibrary.h> //相册
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>
#import <Photos/Photos.h>
#import <sys/utsname.h>
@implementation LLUtility

UIViewController * VisibleViewController(void){
    UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    if ([tab isKindOfClass:[UITabBarController class]])
    {
        UIViewController *vc = ([(UINavigationController *)[[tab viewControllers] objectAtIndex:tab.selectedIndex] visibleViewController]);
        if (vc.presentedViewController)
        {
            if (vc.presentedViewController.presentedViewController)
            {
                return vc.presentedViewController.presentedViewController;
            }
            return vc.presentedViewController;
        }
        else
        {
            return vc;
        }
    }else{
        return [LLUtility getCurrentVC];
    }
    return nil;
}

UIViewController * currViewController(void)
{
    UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    if ([tab isKindOfClass:[UITabBarController class]])
    {
        UIViewController *vc = ([(UINavigationController *)[[tab viewControllers] objectAtIndex:tab.selectedIndex] visibleViewController]);
        if (vc.presentedViewController)
        {
            if (vc.presentedViewController.presentedViewController)
            {
                return vc.presentedViewController.presentedViewController;
            }
            return vc.presentedViewController;
        }
        else
        {
            return vc;
        }
    }else{
        return [LLUtility getCurrentVC];
    }
    return nil;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}


/**
 加载 Xib 文件
 
 @param nibName  Nib 名称
 
 @return instance
 */
+ (id)loadNibWithNibName:(NSString *)nibName{
    NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    if (nibs.count > 0){
        return [nibs lastObject];
    }
    return nil;
}




/**
 提示AlerView

 @param title 标题
 @param message 消息
 @param leftButtomTitle 左边按钮标题
 @param rightButtonTitle 右边按钮标题
 @param leftButtonBlock 右边按钮事件回调
 @param rightButtonBlock 右边按钮事件回调
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtomTitle rightButtonTitle:(NSString *)rightButtonTitle leftButtonBlock:(void (^)(UIAlertAction * action))leftButtonBlock rightButtonBlock:(void (^)(UIAlertAction * action))rightButtonBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title?:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    if (leftButtomTitle) {
        UIAlertAction *leftButton = [UIAlertAction actionWithTitle:leftButtomTitle style:UIAlertActionStyleDefault handler:leftButtonBlock] ;
        [alert addAction:leftButton];
    }
    
    if (rightButtonTitle) {
        UIAlertAction *rightButton = [UIAlertAction actionWithTitle:rightButtonTitle style:UIAlertActionStyleDefault handler:rightButtonBlock];
        [alert addAction:rightButton];
    }
    [VisibleViewController() presentViewController:alert animated:YES completion:nil];
}

#pragma mark -- 数组排序方法（升序）
+ (NSArray *)arraySortASC:(NSArray *)array{
//    NSArray *array = @[@(3),@(4),@(2),@(1)];
    //对数组进行排序
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSLog(@"%@~%@",obj1,obj2); //3~4 2~1 3~1 3~2
        return [obj1 compare:obj2]; //升序
    }];
    NSLog(@"result=%@",result);
    return  result;
}

#pragma mark -- 数组排序方法（降序）
+ (NSArray *)arraySortDESC:(NSArray *)array{
//    NSArray *array = @[@(3),@(4),@(2),@(1)];
    //对数组进行排序
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSLog(@"%@~%@",obj1,obj2); //3~4 2~1 3~1 3~2
        return [obj2 compare:obj1]; //降序
    }];
    NSLog(@"result=%@",result);
    return result;
}

#pragma mark -- 数组排序方法（乱序）
+ (NSArray *)arraySortBreak:(NSArray *)array{
//    NSArray *array = @[@(3),@(4),@(2),@(1),@(5),@(6),@(0)];
    //对数组进行排序
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSLog(@"%@~%@",obj1,obj2);
        //乱序
        if (arc4random_uniform(2) == 0) {
            return [obj2 compare:obj1]; //降序
        }else{
            return [obj1 compare:obj2]; //升序
        }
    }];
    NSLog(@"result=%@",result);
    return result;
}
#pragma mark 正则
+ (CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height{
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}
+ (CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width{
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height;
}
#pragma  mark - 获取当天的日期：年月日
+ (NSDictionary *)getTodayDate{
    //获取今天的日期
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay;
    NSDateComponents *components = [calendar components:unit fromDate:today];
    NSString *year = [NSString stringWithFormat:@"%ld", (long)[components year]];
    NSString *month = [NSString stringWithFormat:@"%ld", (long)[components month]];
    NSString *day = [NSString stringWithFormat:@"%ld", (long)[components day]];
    NSMutableDictionary *todayDic = [[NSMutableDictionary alloc] init];
    [todayDic setObject:year forKey:@"year"];
    [todayDic setObject:month forKey:@"month"];
    [todayDic setObject:day forKey:@"day"];
    return todayDic;
}
//邮箱
+ (BOOL)justEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//手机号码验证
+ (BOOL)justMobile:(NSString *)mobile{
    //手机号以13， 15，18 ,17开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
//车牌号验证
+ (BOOL)justCarNo:(NSString *)carNo{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    //    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}
//车型
+ (BOOL)justCarType:(NSString *)CarType{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}
//用户名
+ (BOOL)justUserName:(NSString *)name{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
//密码
+ (BOOL)justPassword:(NSString *)passWord{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
//昵称
+ (BOOL)justNickname:(NSString *)nickname{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

/**
 是否是iPhoneX 系列
 */
+ (BOOL)isIPhoneXSeries{
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}


/**
 当前时间戳
 */
+ (NSString *)unixTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a*1000];
    return timeString;
}

/**
 //判断中英混合的的字符串长度 英文1 中文2
 */
+ (int)convertToInt:(NSString*)strtemp{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }else {
            p++;
        }
    }
    return strlength;
}

/**
 * @brief 将NSDate对象转换为字符串,需带格式化符号
 */
+ (NSString *)tansformTime:(NSDate *)date DateFormat:(NSString *)dateFormat{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //Mon Oct 31 14:55:31 +0800 2011
    //Wed Nov 2 15:40:17 +0800 2011
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [df setDateFormat:dateFormat];
    NSString * dateString = [df stringFromDate:date];
    return dateString;
}

/**
 * @brief 将NSDate对象转换为字符串,格式化符号  yyyy-MM-dd
 */
+ (NSString *) convertNSStringWithDate:(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //Mon Oct 31 14:55:31 +0800 2011
    //Wed Nov 2 15:40:17 +0800 2011
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * dateString = [df stringFromDate:date];
    return dateString;
}

/**
 * @brief 将字符串转换为NSDate对象
 */
+ (NSDate *)convertNSDateWithString:(NSString *) dateString DateFormat:(NSString *)dateFormat{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [df setDateFormat:dateFormat];
    NSDate * date = [df dateFromString: dateString];
    return date;
}

/**
 *  将NSDate转换成字符串（几分钟以前）
 */
+ (NSString *)converNsstringWithDateAgo:(NSDate *)date{
    NSTimeInterval time = [[NSDate date]  timeIntervalSinceDate:date];
    int hours = ((int) time)/(3600);
    int minutes = ((int) time)/(60);
    
    if(hours > 0 && hours < 24){
        return [[NSString alloc] initWithFormat:@"%d小时前", hours];
    }
    else if(hours <= 0)
    {
        if(minutes > 30){
            return [[NSString alloc] initWithFormat:@"半小时前"];
        }else if (minutes > 0) {
            return [[NSString alloc] initWithFormat:@"%d分钟前", minutes];
        }else {
            return @"刚刚";
        }
    }
    return [self convertNSStringWithDate:date];
}
/**
 *   十六进制color转为UIColor  and alpha
 */
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert alpha:(CGFloat)alpha{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

/**
 *获取屏幕截屏
 */
+ (UIImage *)getScreenshot{
    UIWindow *screenWindow = [[UIApplication sharedApplication] delegate].window;
    UIGraphicsBeginImageContext(screenWindow.frame.size);//全屏截图，包括window
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}
/**
 * 计算字符串 size
 */
+ (CGSize)stringSizeWithString:(NSString*)string Font:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize contentSize = CGSizeZero;
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        contentSize = [string sizeWithAttributes:attributes];
    }else {
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        CGRect rect = [string boundingRectWithSize:size
                                           options:option
                                        attributes:attributes
                                           context:nil];
        contentSize = rect.size;
    }
    return contentSize;
}

/**
 *获取视频时间
 */
+ (NSString *)getVideoTime:(NSInteger)videoTime{
    NSInteger allTime = videoTime;
    allTime = allTime / 1000;
    NSInteger min = allTime / 60;
    NSInteger second = allTime % 60;
    NSMutableString *timeStr = [NSMutableString string];
    if (min < 10) {
        [timeStr appendFormat:@"0%ld",(long)min];
    }else {
        [timeStr appendFormat:@"%ld",(long)min];
    }
    if (second < 10) {
        [timeStr appendFormat:@":0%ld",(long)second];
    }else
    {
        [timeStr appendFormat:@":%ld",(long)second];
    }
    return timeStr;
}


/**
 收取视频首帧
 */
+ (UIImage *)thumbnailImageRequest:(NSURL *)videoUrl{
    //创建URL
    NSURL *url=videoUrl;
    //根据url创建AVURLAsset
    AVURLAsset *urlAsset=[AVURLAsset assetWithURL:url];
    //根据AVURLAsset创建AVAssetImageGenerator
    AVAssetImageGenerator *imageGenerator=[AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    /*截图
     * requestTime:缩略图创建时间
     * actualTime:缩略图实际生成的时间
     */
    NSError *error=nil;
    CMTime time=CMTimeMakeWithSeconds(0, 10);//CMTime是表示电影时间信息的结构体，第一个参数是视频第几秒，第二个参数时每秒帧数.(如果要活的某一秒的第几帧可以使用CMTimeMake方法)
    CMTime actualTime;
    CGImageRef cgImage= [imageGenerator copyCGImageAtTime:time actualTime:&actualTime error:&error];
    if(error){
        NSLog(@"截取视频缩略图时发生错误，错误信息：%@",error.localizedDescription);
        return nil;
    }
    CMTimeShow(actualTime);
    UIImage *image=[UIImage imageWithCGImage:cgImage];//转化为UIImage
    return  image;
}

/**
 * 将颜色转换成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color{
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)imageSize{
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 使用 创建自定义名称的相册 并获取自定义到自定义相册
 
 @param name 相册名称  如果没有 则使用APP的名称
 */
+ (void)createAlbumInPhoneAlbumWithName:(NSString *__nullable)name{
    // 获取自定义相册
    PHAssetCollection *createdCollection = [self createCustomAssetCollectionWithName:name];
    if (createdCollection == nil) {
        NSLog(@"创建相册失败");
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        NSMutableArray *groups=[[NSMutableArray alloc]init];
        ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop){
            if (group){
                [groups addObject:group];
            }else{
                BOOL haveGroup = NO;
                for (ALAssetsGroup *gp in groups){
                    NSString *name =[gp valueForProperty:ALAssetsGroupPropertyName];
                    if ([name isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]]){
                        haveGroup = YES;  //相册中存在 合拍
                    }
                }
                if (!haveGroup){
                    [assetsLibrary addAssetsGroupAlbumWithName:[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey]
                                                   resultBlock:^(ALAssetsGroup *group){
                                                       if (group) {
                                                           [groups addObject:group];
                                                       }else{
                                                           
                                                       }
                                                   }failureBlock:nil];
                    haveGroup = YES;
                    NSLog(@"%d",haveGroup);
                }
            }
        };
        //创建相簿
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listGroupBlock failureBlock:nil];
    }
}
/**
 使用 photo 框架创建自定义名称的相册 并获取自定义到自定义相册

 @param name 相册名称  如果没有 则使用APP的名称
 */
+ (PHAssetCollection *)createCustomAssetCollectionWithName:(NSString *__nullable)name{
    // 获取 app 名称
    if (!name || name.length < 1) {
        NSString *title = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
        name = title;
    }
    NSError *error = nil;
    // 查找 app 中是否有该相册 如果已经有了 就不再创建
    /**
     *     参数一 枚举：
     *     PHAssetCollectionTypeAlbum      = 1, 用户自定义相册
     *     PHAssetCollectionTypeSmartAlbum = 2, 系统相册
     *     PHAssetCollectionTypeMoment     = 3, 按时间排序的相册
     *
     *     参数二 枚举：PHAssetCollectionSubtype
     *     参数二的枚举有非常多，但是可以根据识别单词来找出我们想要的。
     *     比如：PHAssetCollectionTypeSmartAlbum 系统相册 PHAssetCollectionSubtypeSmartAlbumUserLibrary 用户相册 就能获取到相机胶卷
     *     PHAssetCollectionSubtypeAlbumRegular 常规相册
     */
    PHFetchResult<PHAssetCollection *> *result = [PHAssetCollection fetchAssetCollectionsWithType:(PHAssetCollectionTypeAlbum)
                                                                                          subtype:(PHAssetCollectionSubtypeAlbumRegular)
                                                                                          options:nil];
    
    for (PHAssetCollection *collection in result) {
        if ([collection.localizedTitle isEqualToString:name]) { // 说明 app 中存在该相册
            return collection;
        }
    }
    /** 来到这里说明相册不存在 需要创建相册 **/
    __block NSString *createdCustomAssetCollectionIdentifier = nil;
    // 创建和 app 名称一样的 相册
    /**
     * 注意：这个方法只是告诉 photos 我要创建一个相册，并没有真的创建
     *      必须等到 performChangesAndWait block 执行完毕后才会
     *      真的创建相册。
     */
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *collectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:name];
        /**
         * collectionChangeRequest 即使我们告诉 photos 要创建相册，但是此时还没有
         * 创建相册，因此现在我们并不能拿到所创建的相册，我们的需求是：将图片保存到
         * 自定义的相册中，因此我们需要拿到自己创建的相册，从头文件可以看出，collectionChangeRequest
         * 中有一个占位相册，placeholderForCreatedAssetCollection ，这个占位相册
         * 虽然不是我们所创建的，但是其 identifier 和我们所创建的自定义相册的 identifier
         * 是相同的。所以想要拿到我们自定义的相册，必须保存这个 identifier，等 photos app
         * 创建完成后通过 identifier 来拿到我们自定义的相册
         */
        createdCustomAssetCollectionIdentifier = collectionChangeRequest.placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    // 这里 block 结束了，因此相册也创建完毕了
    if (error) return nil;
    if (createdCustomAssetCollectionIdentifier) {
        return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCustomAssetCollectionIdentifier] options:nil].firstObject;
    }else{
        return nil;
    }
}

//保存视频或者图片到 相册 -
+ (void)saveImage:(UIImage *__nullable)image video:(NSString *__nullable)video customAlbumName:(NSString *)customAlbumName{
    [self saveToAlbumWithMetadata:nil imageData:UIImagePNGRepresentation(image) videoData:video customAlbumName:customAlbumName completionBlock:^{
        //这里可以创建添加成功的方法
    }failureBlock:^(NSError *error){
        //处理添加失败的方法显示alert让它回到主线程执行，不然那个框框死活不肯弹出来
        dispatch_async(dispatch_get_main_queue(), ^{
            //添加失败一般是由用户不允许应用访问相册造成的，这边可以取出这种情况加以判断一下
            if([error.localizedDescription rangeOfString:@"User denied access"].location != NSNotFound ||[error.localizedDescription rangeOfString:@"用户拒绝访问"].location!=NSNotFound){
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:error.localizedDescription message:error.localizedFailureReason delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
                [alert show];
            }
        });
    }];
}
//保存视频或者图片到 相册 -
+ (void)saveToAlbumWithMetadata:(NSDictionary *__nullable)metadata
                      imageData:(NSData *__nullable)imageData
                      videoData:(NSString *__nullable)videoData
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock{
    
    __block ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    __weak ALAssetsLibrary *weakassetsLibrary = assetsLibrary;
    void (^AddAsset)(ALAssetsLibrary *, NSURL *) = ^(ALAssetsLibrary *assetsLibrary, NSURL *assetURL) {
        [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [weakassetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customAlbumName]) {
                    [group addAsset:asset];
                    if (completionBlock) {
                        completionBlock();
                    }
                }
            } failureBlock:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    };
    if (imageData) {
        [assetsLibrary writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
            if (customAlbumName) {
                [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName resultBlock:^(ALAssetsGroup *group) {
                    if (group) {
                        [weakassetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                            [group addAsset:asset];
                            if (completionBlock) {
                                completionBlock();
                            }
                        } failureBlock:^(NSError *error) {
                            if (failureBlock) {
                                failureBlock(error);
                            }
                        }];
                    } else {
                        AddAsset(weakassetsLibrary, assetURL);
                    }
                } failureBlock:^(NSError *error) {
                    AddAsset(weakassetsLibrary, assetURL);
                }];
            } else {
                if (completionBlock) {
                    completionBlock();
                }
            }
        }];
    }
    
    if (videoData) {
        [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:videoData] completionBlock:^(NSURL *assetURL, NSError *error){
            if (customAlbumName) {
                [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName resultBlock:^(ALAssetsGroup *group) {
                    if (group) {
                        [weakassetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                            [group addAsset:asset];
                            if (completionBlock) {
                                completionBlock();
                            }
                        } failureBlock:^(NSError *error) {
                            if (failureBlock) {
                                failureBlock(error);
                            }
                        }];
                    } else {
                        AddAsset(weakassetsLibrary, assetURL);
                    }
                } failureBlock:^(NSError *error) {
                    AddAsset(weakassetsLibrary, assetURL);
                }];
            } else {
                if (completionBlock) {
                    completionBlock();
                }
            }
        }];
    }
}


//指定宽度按比例缩放
+ (UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

//按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        } else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 提示AlerView
 
 @param title 标题
 @param message 消息
 @param leftButtomTitle 左边按钮标题
 @param rightButtonTitle 右边按钮标题
 @param leftButtonBlock 右边按钮事件回调
 @param rightButtonBlock 右边按钮事件回调
 */
+ (void)showAlertWithCurVC:(UIViewController *)curVC title:(NSString *__nullable)title message:(NSString *__nullable)message leftButtonTitle:(NSString *__nullable)leftButtomTitle rightButtonTitle:(NSString *__nullable)rightButtonTitle leftButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action))leftButtonBlock rightButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action))rightButtonBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title?:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    if (leftButtomTitle && leftButtomTitle.length > 0 ) {
        UIAlertAction *leftButton = [UIAlertAction actionWithTitle:leftButtomTitle style:UIAlertActionStyleDefault handler:leftButtonBlock] ;
        [alert addAction:leftButton];
    }
    
    if (rightButtonTitle && rightButtonTitle.length > 0) {
        UIAlertAction *rightButton = [UIAlertAction actionWithTitle:rightButtonTitle style:UIAlertActionStyleDefault handler:rightButtonBlock];
        [alert addAction:rightButton];
    }
    [curVC presentViewController:alert animated:YES completion:nil];
}


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
+ (void)showAlertTextFieldWithCurVC:(UIViewController *)curVC title:(NSString *__nullable)title  defluteStr:(NSString *__nullable)defluteStr placeholderStr:(NSString *__nullable)placeholder  leftButtonTitle:(NSString *__nullable)leftButtomTitle rightButtonTitle:(NSString *__nullable)rightButtonTitle leftButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action,NSString *inputStr))leftButtonBlock rightButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action,NSString *inputStr))rightButtonBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title?:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder?:@"请输入";
        textField.text = defluteStr;
    }];
    if (leftButtomTitle && leftButtomTitle.length > 0 ) {
        UIAlertAction *leftButton = [UIAlertAction actionWithTitle:leftButtomTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (leftButtonBlock) {
                UITextField *textField = alert.textFields.firstObject;
                leftButtonBlock(action,textField.text);
            }
        }] ;
        [alert addAction:leftButton];
    }
    if (rightButtonTitle && rightButtonTitle.length > 0) {
        UIAlertAction *rightButton = [UIAlertAction actionWithTitle:rightButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (rightButtonBlock) {
                UITextField *textField = alert.textFields.firstObject;
                rightButtonBlock(action,textField.text);
            }
        }];
        [alert addAction:rightButton];
    }
    [curVC presentViewController:alert animated:YES completion:nil];
}

/**
 提示SheetView
 
 @param title 标题
 @param message 消息
 */
+ (void)showSheetWithCurVC:(UIViewController *)curVC title:(NSString *__nullable)title message:(NSString *__nullable)message firstButtonTitle:(NSString *__nullable)firstButtonTitle secondButtonTitle:(NSString *__nullable)secondButtonTitle thirdButtonTitle:(NSString *__nullable)thirdButtonTitle firstButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action))firstButtonBlock secondButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action))secondButtonBlock thirdButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action))thirdButtonBlock cancelButtonBlock:(void (^_Nullable)(UIAlertAction * _Nonnull action))cancelButtonBlock{
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    if (firstButtonTitle && firstButtonTitle.length > 0) {
        UIAlertAction *leftButton = [UIAlertAction actionWithTitle:firstButtonTitle style:UIAlertActionStyleDefault handler:firstButtonBlock] ;
        [sheet addAction:leftButton];
    }
    if (secondButtonTitle && secondButtonTitle.length > 0) {
        UIAlertAction *rightButton = [UIAlertAction actionWithTitle:secondButtonTitle style:UIAlertActionStyleDefault handler:secondButtonBlock];
        [sheet addAction:rightButton];
    }
    if (thirdButtonTitle && thirdButtonTitle.length > 0) {
        UIAlertAction *rightButton = [UIAlertAction actionWithTitle:thirdButtonTitle style:UIAlertActionStyleDefault handler:thirdButtonBlock];
        [sheet addAction:rightButton];
    }
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancelButtonBlock];
        [sheet addAction:cancelButton];
    [curVC presentViewController:sheet animated:YES completion:nil];
}
/**
 识别脸部
 
 @param image 图片
 @return 如果有显示脸部 = YES
 */
+ (BOOL)checkImagefineFaceWithImage:(UIImage *)image{
    BOOL has = NO;
    CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:nil options:[NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy]];
    NSArray *features = [faceDetector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    if (features.count > 0) {
        has = YES;
    }
    return has;
}

///生成随机字符串 数字+字母 length 长度
+ (NSString *)randomStringWithLength:(int)length{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < length; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97 - 32;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    NSLog(@"%@", string);
    return string;
}
///生成随机字符串 数字 length 长度
+ (NSString *)randomStringNumberWithLength:(int)length{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < length; i++) {
        int figure = arc4random() % 10;
        NSString *tempString = [NSString stringWithFormat:@"%d", figure];
        string = [string stringByAppendingString:tempString];
    }
    NSLog(@"%@", string);
    return string;
}
///生成字母随机字符串 length 长度
+ (NSString *)randomStringLetterWithLength:(int)length{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < length; i++) {
        int figure = (arc4random() % 26) + 97 - 32;
        char character = figure;
        NSString *tempString = [NSString stringWithFormat:@"%c", character];
        string = [string stringByAppendingString:tempString];
    }
    NSLog(@"%@", string);
    return string;
}

//有没有设置代理
+ (BOOL)checkProxySetting{
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"https://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    //    NSLog(@"\n%@",proxies);
    NSDictionary *settings = proxies[0];
    //    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    //    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    //    NSLog(@"%@",[settings objectForKey:(NSString *)kCFProxyTypeKey]);
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        NSLog(@"没设置代理");
        return NO;
    }else{
        NSLog(@"设置了代理");
        return YES;
    }
}

//view 转图片
+ (UIImage *)snapsHotView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,YES,[UIScreen mainScreen].scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//html 转 NSAttributedString
+ (NSAttributedString *)attributeStrWithHtml:(NSString *)html{
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithData:[html?:@"" dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    return attributeStr;
}

///判断字符串是否为浮点数
+ (BOOL)isPureFloat:(NSString*)string{
    if (string && string.length > 0) {
        NSScanner* scan = [NSScanner scannerWithString:string];
        float val;
        return[scan scanFloat:&val] && [scan isAtEnd];
    }else{
        return NO;
    }
}
///判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string{
    if (string && string.length > 0) {
        NSScanner* scan = [NSScanner scannerWithString:string];
        int val;
        return [scan scanInt:&val] && [scan isAtEnd];
    }else{
        return NO;
    }
}


/**
  tableView滑到最底部
 */
+ (void)scrollTableToFoot:(BOOL)animated tableView:(UITableView *)tableView{
    if (tableView) {
        NSInteger s = [tableView numberOfSections];  //有多少组
        if (s < 1){
            return;  //无数据时不执行 要不会crash
        }
        NSInteger r = [tableView numberOfRowsInSection:s-1]; //最后一组有多少行
        if (r < 1){
            return;
        }
        NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
        [tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
    }
}

//计算label 行数
+ (NSInteger)needLinesWithWidth:(CGFloat)width font:(UIFont *)font text:(NSString *)text{
    //创建一个labe
    UILabel * label = [[UILabel alloc]init];
    //font和当前label保持一致
    label.font = font;
    NSInteger sum = 0;
    //总行数受换行符影响，所以这里计算总行数，需要用换行符分隔这段文字，然后计算每段文字的行数，相加即是总行数。
    NSArray * splitText = [text componentsSeparatedByString:@"\n"];
    for (NSString * sText in splitText) {
        label.text = sText;
        //获取这段文字一行需要的size
        CGSize textSize = [label systemLayoutSizeFittingSize:CGSizeZero];
        //size.width/所需要的width 向上取整就是这段文字占的行数
        NSInteger lines = ceilf(textSize.width/width);
        //当是0的时候，说明这是换行，需要按一行算。
        lines = lines == 0?1:lines;
        sum += lines;
    }
    return sum;
}

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
                                  imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case 3:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end,kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

/**
 获取url host 头部
 */
+ (NSString *)hostStringWithUrlString:(NSString *)urlStr{
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count > 0) {
            NSString *paramsStr = array[0];
            return paramsStr;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}


/**
 获取url 携带的参数
 */
+ (NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr{
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            NSString *paramsStr = array[1];
            if (paramsStr.length) {
                NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
                NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
                for (NSString *param in paramArray) {
                    if (param && param.length) {
                        NSArray *parArr = [param componentsSeparatedByString:@"="];
                        if (parArr.count == 2) {
                            [paramsDict setObject:parArr[1] forKey:parArr[0]];
                        }
                    }
                }
                return paramsDict;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

/**
 输入数字时一些限制
 @param limitZero 首输是否限制输0
 @param NumberDecimalPoints 小数点后位数
 */
+ (BOOL)inputLimitTextField:(UITextField *)textField
                         range:(NSRange)range
                        string:(NSString *)string
                     limitZero:(BOOL)limitZero NumberDecimalPoints:(NSInteger)NumberDecimalPoints{
    NSMutableString * futureString = [NSMutableString stringWithString:textField.text];
    [futureString  insertString:string atIndex:range.location];
    
    if (limitZero) {
        if (range.location == 0 && [string isEqualToString:@"0"]) {
            return NO;
        }
    }
    
    if (range.location == 0 && [string isEqualToString:@"."]) {
        return NO;
    }
    // 限制小数点个数不超过两个
    NSArray * textArr = [textField.text componentsSeparatedByString:@"."];
    if (textArr.count >= 2 && [string isEqualToString:@"."]) {
        return NO;
    }
    
    NSInteger flag = 0;
    const NSInteger limited = NumberDecimalPoints;//小数点后需要限制的个数
    for (NSInteger i = futureString.length-1; i>=0; i--) {
        
        if ([futureString characterAtIndex:i] == '.') {
            if (flag > limited) {
                return NO;
            }
            break;
        }
        flag++;
    }
    return YES;
}

/**
 字数限制截断
 */
+ (void)spaceConstraintsLimitString:(UITextField *)Textfield
                          limitMaxWord:(NSInteger)limitMaxWord{
    if (Textfield.text.length > limitMaxWord) {
        UITextRange *markedRange = [Textfield markedTextRange];
        if (markedRange) {
            return;
        }
        //Emoji占2个字符，如果是超出了半个Emoji，用15位置来截取会出现Emoji截为2半
        //超出最大长度的那个字符序列(Emoji算一个字符序列)的range
        NSString * temText = @"";
        NSString * checker = [NSString stringWithFormat:@"%C", 8198]; // 英文输入时的字符集
        if ([Textfield.text rangeOfString:checker].length) {
            temText = [Textfield.text stringByReplacingOccurrencesOfString:checker withString:@""];
        }else{
            temText = Textfield.text;
        }
        
        NSRange range = [temText rangeOfComposedCharacterSequenceAtIndex:limitMaxWord];
        Textfield.text = [temText substringToIndex:range.location];
    }
}

/**
 @param limitMaxWord 限制最大数
 @param wordBool 是否显示提示
 */
+ (BOOL)spaceConstraintsLimit:(NSString *)TextString
                    limitMaxWord:(NSInteger)limitMaxWord
                     waringBlock:(void (^_Nullable)(NSString *hint))waringBlock{
    NSString * temText = @"";
    NSString * checker = [NSString stringWithFormat:@"%C", 8198]; // 英文输入时的字符集
    if ([TextString rangeOfString:checker].length) {
        temText = [TextString stringByReplacingOccurrencesOfString:checker withString:@""];
    }else{
        temText = TextString;
    }
    if (temText.length > limitMaxWord) {
        if (waringBlock) {
            waringBlock([NSString stringWithFormat:@"不能超过%ld个字",limitMaxWord]);
        }
        return NO;
    }
    return YES;
}

@end

