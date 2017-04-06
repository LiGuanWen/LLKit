//
//  ImageBrowerView.m
//  ImageBrowerTest
//
//  Created by JPlay on 14-6-13.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import "ImageBrowerView.h"
#import "BrowerFlowLayout.h"

#define IMAGE_CELL_PADDING 10


@interface ImageBrowerView ()
    
@property (nonatomic, strong) BrowerFlowLayout *browerFlowLayout;


@end



@implementation ImageBrowerView

-(id)initWithDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)delegate{
    self = [super init];
    if (self) {
        self.browerFlowLayout = [[BrowerFlowLayout alloc] init];
        self.internalPageView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                   collectionViewLayout:self.browerFlowLayout];
        self.delegate = delegate;
        self.internalPageView.showsVerticalScrollIndicator = NO;
        self.internalPageView.dataSource = self.delegate;
        self.internalPageView.delegate = self.delegate;
        [self addSubview:self.internalPageView];
        
        [self.internalPageView registerNib:[UINib nibWithNibName:@"BrowerImageCell" bundle:nil] forCellWithReuseIdentifier:@"BrowerImageCell"];
        
    }
    return self;

}


-(void)setDelegate:(id<UICollectionViewDataSource,UICollectionViewDelegate>)delegate{
    
    _delegate = delegate;
    _internalPageView.dataSource = _delegate;
    _internalPageView.delegate = _delegate;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.internalPageView.frame = CGRectMake(-IMAGE_CELL_PADDING/2.0,
                                         0,
                                         CGRectGetWidth(self.bounds) + IMAGE_CELL_PADDING,
                                         CGRectGetHeight(self.bounds));
    
    
    [self.browerFlowLayout invalidateLayout];
}








@end
