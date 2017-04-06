//
//  ImageBrowerViewController.m
//  OhMyBaby
//
//  Created by JPlay on 14-6-12.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import "ImageBrowerViewController.h"
#import "BrowerImageCell.h"
#import "BrowerFlowLayout.h"
#import "ImageBrowerView.h"

@interface ImageBrowerViewController () <UICollectionViewDataSource,UICollectionViewDelegate,BrowerImageCellDelegate>


@end

@implementation ImageBrowerViewController

- (instancetype)initWithIndexOfPhoto:(NSInteger)indexOfPhoto canEdit:(BOOL)canEdit photoList:(NSMutableArray *)photoList{
    self = [super init];
    if (self) {
        self.canEdit = canEdit;
        self.indexOfPhoto = indexOfPhoto;
        self.photoList = photoList;
        if (self.photoList == nil) {
            self.photoList = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (instancetype)initWithCanEdit:(BOOL)canEdit assetList:(NSMutableArray *)assetList{
    self = [super init];
    if (self) {
        self.canEdit = canEdit;
        self.indexOfPhoto = 0;
        self.assetList = assetList;
        self.photoList = [[NSMutableArray alloc] init];
        if (self.assetList == nil) {
            self.assetList = [[NSMutableArray alloc] init];
        }else{
            for (ELCAsset *elcAsset in self.assetList) {
                if ([elcAsset selected]) {
                    ALAssetRepresentation *assetRep = [elcAsset.asset defaultRepresentation];
                    if(assetRep != nil) {
                        CGImageRef imgRef = nil;
                        UIImageOrientation orientation = UIImageOrientationUp;
                        imgRef = [assetRep fullResolutionImage];
                        orientation = (UIImageOrientation)[assetRep orientation];
                        UIImage *img = [UIImage imageWithCGImage:imgRef
                                                           scale:1.0f
                                                     orientation:orientation];
                        Photo *photo = [[Photo alloc] init];
                        photo.cachedImage = img;
                        [self.photoList addObject:photo];
                    }
                }
            }
        }
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    ImageBrowerView *pageView = [[ImageBrowerView alloc] initWithDelegate:self];
    self.view = pageView;
}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    
    //根据indexOfImage跳转到该cell
    if (self.indexOfPhoto > 0 && self.indexOfPhoto < self.photoList.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.indexOfPhoto inSection:0];
        ImageBrowerView *pageView = (ImageBrowerView *)self.view;
        [pageView.internalPageView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
}


#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.photoList.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BrowerImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BrowerImageCell"
                                                                      forIndexPath:indexPath];
    if (cell.delegate == nil) {
        cell.delegate = self;
    }

    [cell setCellWithPhoto:self.photoList[indexPath.row] canEdit:self.canEdit photoCount:self.photoList.count photoIndex:indexPath.row];
    if (self.hideTopBar == YES) {
        [cell hideTopView];
    }
    
    if (self.bgColor) {
        cell.contentView.backgroundColor = self.bgColor;
    }
    
    return cell;
    
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectItem");
}



#pragma mark - BrowerImageCellDelegate

-(void)didClickImageCellBackButton {
//    [[NSNotificationCenter defaultCenter] postNotificationName:ImageBrowserDismissed object:nil];

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didClickImageCellRightButtonWithPhoto:(Photo *)photo {
    
    NSInteger index = [self.photoList indexOfObject:photo];
    [self.photoList removeObject:photo];
    [self.assetList[index] setSelected:NO];
    
    if (self.photoList.count == 0) {
        [self didClickImageCellBackButton];
    }
    
    ImageBrowerView *pageView = (ImageBrowerView *)self.view;
    [pageView.internalPageView reloadData];
    
    //通知前一页刷新UICollectionView
//    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_IMAGE_LIST object:photo];
}



@end
