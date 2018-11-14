//
//  UICollectionView+RegisterNib.h
//  AFNetworking
//
//  Created by 李观文 on 2018/8/8.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (RegisterNib)
- (void)registerCellNibWithNibName:(NSString *) nibName;
- (void)registerCellClassWithClassName:(NSString *) className;
- (void)multiRegisterCellNibsWithNibNames:(NSArray *) nibNames;

@end
