
//
//  LLUtility.m
//  Pods
//
//  Created by Lilong on 2017/6/15.
//
//

#import "LLUtility.h"

@implementation LLUtility


/**
 创建文件夹

 @param fileName 文件夹名称
 @return 是否成功
 */
+ (BOOL)createFolderIfNotExistWithfolderName:(NSString *)folderName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *folderPath = [path stringByAppendingPathComponent:folderName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];
    
    if(!(isDirExist && isDir)){
        BOOL bCreateDir = [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"创建图片文件夹失败");
            return NO;
        }
        return YES;
    }
    return YES;
}

/**
 删除视频文件夹
 */
+ (void)deleteFolderWithfolderName:(NSString *)folderName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *folderPath = [path stringByAppendingPathComponent:folderName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:folderPath error:nil];
}


/**
 获取摸个文件夹下的所有文件
 @param filePath 路径
 */
+ (NSArray *)getAllFileInFolderWithFilePath:(NSString *)filePath{
    //step6. 获取沙盒里所有文件
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSError *error = nil;
    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:filePath error:&error];
    return fileList;
}


// 对数组乱序
+ (NSArray *)randamArry:(NSArray *)arry{
    arry = [arry sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    return arry;
}

/**
 获取当前的NSDate
 */
+ (NSDate *)getNowDateWithFormString:(NSString *)formString{
    if (formString) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];// ------实例化一个NSDateFormatter对象
        [formatter setDateFormat:formString]; //这里的格式必须和String格式一致
        NSString *dateTime = [formatter stringFromDate:[NSDate date]];
        NSDate *date = [formatter dateFromString:dateTime];
        return date;
    }else{
        return nil;
    }
}

/**
 比较两个时间段的早晚  两个时间比较大小 time1 和time2 的格式必须为 “YYYY-MM-dd HH:mm:ss”
 如果  time1 > time2 =>NSOrderedDescending
 time1 < time2 =>NSOrderedAscending
 time1 == time2 =>NSOrderedSame
 */
+ (NSComparisonResult)compareTime1:(NSString *)time1 time2:(NSString *)time2{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];// ------实例化一个NSDateFormatter对象
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //这里的格式必须和String格式一致
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 =[formatter dateFromString:time2];
    NSComparisonResult result =[date1 compare:date2];
    return result;
}

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
+ (NSDateComponents *)componentsDate1:(NSDate *)date1 data2:(NSDate *)date2{
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:date1 toDate:date2 options:0];
    return dateCom;
}
//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)format{
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    if (format.length < 1) {
        format = @"yyyy-MM-dd HH:mm:ss zzz";
    }
    [dateFormatter setDateFormat:format];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    //输出currentDateString
    NSLog(@"%@",currentDateString);
    return currentDateString;
}

//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string format:(NSString *)format{
    //需要转换的字符串
    NSString *dateString = string;
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    if (format.length < 1) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    [formatter setDateFormat:format];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

/**
 获取当前的viewcontroller
 */
UIViewController * VisibleViewController(){
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
    }
    return nil;
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
+ (void)showAlertWithCurrVC:(UIViewController *)currVC title:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtomTitle rightButtonTitle:(NSString *)rightButtonTitle leftButtonBlock:(void (^)(UIAlertAction *  action))leftButtonBlock rightButtonBlock:(void (^)(UIAlertAction *  action))rightButtonBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title?:@"" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    if (leftButtomTitle) {
        UIAlertAction *leftButton = [UIAlertAction actionWithTitle:leftButtomTitle style:UIAlertActionStyleDefault handler:leftButtonBlock] ;
        [alert addAction:leftButton];
    }
    
    if (rightButtonTitle) {
        UIAlertAction *rightButton = [UIAlertAction actionWithTitle:rightButtonTitle style:UIAlertActionStyleDefault handler:rightButtonBlock];
        [alert addAction:rightButton];
    }
    [currVC presentViewController:alert animated:YES completion:nil];
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
+ (BOOL) justMobile:(NSString *)mobile{
    //手机号以13， 15，18 ,17开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
//车牌号验证
+ (BOOL) justCarNo:(NSString *)carNo{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    //    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}
//车型
+ (BOOL) justCarType:(NSString *)CarType{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}
//用户名
+ (BOOL) justUserName:(NSString *)name{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
//密码
+ (BOOL) justPassword:(NSString *)passWord{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
//昵称
+ (BOOL) justNickname:(NSString *)nickname{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

@end





#pragma mark - UITableView

@implementation UITableView (RegisterNib)

- (void)registerCellNibWithNibName:(NSString *)nibName{
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
}

- (void)registerCellClassWithClassName:(NSString *)className{
    [self registerClass:NSClassFromString(className) forCellReuseIdentifier:className];
}

- (void)multiRegisterCellNibsWithNibNames:(NSArray *)nibNames{
    for (NSString * nibName in nibNames){
        [self registerCellNibWithNibName:nibName];
    }
}

@end

#pragma mark - UICollectionView

@implementation UICollectionView (RegisterNib)

- (void)registerCellNibWithNibName:(NSString *)nibName{
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:nibName];
}

- (void)registerCellClassWithClassName:(NSString *)className{
    [self registerClass:NSClassFromString(className) forCellWithReuseIdentifier:className];
}

- (void)multiRegisterCellNibsWithNibNames:(NSArray *)nibNames{
    for (NSString * nibName in nibNames)
    {
        [self registerCellNibWithNibName:nibName];
    }
}


@end
