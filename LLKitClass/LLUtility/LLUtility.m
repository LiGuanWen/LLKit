
//
//  LLUtility.m
//  Pods
//
//  Created by Lilong on 2017/6/15.
//
//

#import "LLUtility.h"

@implementation LLUtility

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
