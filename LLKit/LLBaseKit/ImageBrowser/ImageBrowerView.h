//
//  ImageBrowerView.h
//  ImageBrowerTest
//
//  Created by JPlay on 14-6-13.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ImageBrowerView : UIView

@property(nonatomic, weak) id <UICollectionViewDataSource,UICollectionViewDelegate> delegate;
@property (nonatomic, strong) UICollectionView *internalPageView;



-(id)initWithDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)delegate;

@end
