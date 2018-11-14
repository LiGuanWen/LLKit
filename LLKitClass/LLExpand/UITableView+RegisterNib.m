//
//  UITableView+RegisterNib.m
//  AFNetworking
//
//  Created by 李观文 on 2018/8/8.
//

#import "UITableView+RegisterNib.h"

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
