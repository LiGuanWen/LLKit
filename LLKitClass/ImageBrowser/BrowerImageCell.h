//
//  BrowerImageCell.h
//  OhMyBaby
//
//  Created by JPlay on 14-6-12.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPFZoomImageView.h"
#import "Photo.h"


@protocol BrowerImageCellDelegate <NSObject>

@optional
-(void)didClickImageCellBackButton;

-(void)didClickImageCellRightButtonWithPhoto:(Photo *)photo;

-(void)didClickPlayButton:(Photo*)photo;

@end

@interface BrowerImageCell : UICollectionViewCell<ZoomImageViewDelegate>

@property (strong, nonatomic)  WPFZoomImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *pageNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property(weak, nonatomic) id <BrowerImageCellDelegate> delegate;
@property(nonatomic, strong) Photo *photo;
@property (nonatomic,assign) BOOL canEdit;


-(void)setCellWithPhoto:(Photo *)photo canEdit:(BOOL)canEdit photoCount:(NSInteger)photoCount photoIndex:(NSInteger)photoIndex;

- (void)hideTopView;

@end
