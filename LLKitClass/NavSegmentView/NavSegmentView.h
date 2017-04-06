//
//  NavSegmentView.h
//  News
//
//  Created by Lilong on 2016/12/13.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavSegmentView : UIView
@property (assign, nonatomic) NSInteger itemWidth;
@property (assign, nonatomic) NSInteger itemHeight;
@property (copy, nonatomic) NSArray * items;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (copy, nonatomic) void (^clickedBlock) (NSInteger index);

- (instancetype)initWithItems:(NSArray *) items;
- (instancetype)initWithItems:(NSArray *) items itemWidth:(float)itemWidth itemHeight:(float)itemHeight;

@end
