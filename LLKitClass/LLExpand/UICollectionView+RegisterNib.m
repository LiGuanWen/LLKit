//
//  UICollectionView+RegisterNib.m
//  AFNetworking
//
//  Created by 李观文 on 2018/8/8.
//

#import "UICollectionView+RegisterNib.h"

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
