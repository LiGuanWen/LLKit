//
//  ImageBrowerViewController.h
//  OhMyBaby
//
//  Created by JPlay on 14-6-12.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCAsset.h"



@interface ImageBrowerViewController : UIViewController

@property (nonatomic,assign) BOOL canEdit;
@property (nonatomic,assign) BOOL hideTopBar;
@property (nonatomic,strong) NSMutableArray *photoList;
@property (nonatomic,strong) NSMutableArray *assetList;
@property (nonatomic,assign) NSInteger indexOfPhoto;
@property (nonatomic,strong) UIColor *bgColor;

- (instancetype)initWithIndexOfPhoto:(NSInteger)indexOfPhoto canEdit:(BOOL)canEdit photoList:(NSMutableArray *)photoList;

- (instancetype)initWithCanEdit:(BOOL)canEdit assetList:(NSMutableArray *)assetList;


@end
