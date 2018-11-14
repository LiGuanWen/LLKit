
//
//  LLUtility.m
//  Pods
//
//  Created by Lilong on 2017/6/15.
//
//

#import "LLUtility.h"

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



@end

