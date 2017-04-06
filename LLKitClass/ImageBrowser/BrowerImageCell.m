//
//  BrowerImageCell.m
//  OhMyBaby
//
//  Created by JPlay on 14-6-12.
//  Copyright (c) 2014年 JPlay. All rights reserved.
//

#import "BrowerImageCell.h"

@interface BrowerImageCell ()

@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


@end

@implementation BrowerImageCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.imageView = [[WPFZoomImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.imageView.delegate = self;
    self.imageView.image = [UIImage imageNamed:@"placeholder_260_260"];
    [self.contentView insertSubview:self.imageView atIndex:0];

}


-(void)setCellWithPhoto:(Photo *)photo canEdit:(BOOL)canEdit photoCount:(NSInteger)photoCount photoIndex:(NSInteger)photoIndex{
//    if (self.topView.hidden == NO) {
//        self.topView.hidden = YES;
//    }
    if (canEdit == YES) {
        self.deleteButton.hidden = NO;
    }
    else {
        self.deleteButton.hidden = YES;

    }
    self.photo = photo;
    
    if (photo.cachedImage) {
        [self.imageView setImage:photo.cachedImage];
    }else if(photo.originalImageURL &&
             ![photo.originalImageURL isEqualToString:@""]) {
        [self.imageView setImageWithURL:photo.originalImageURL];
    }
    else if(photo.isVideo == YES) {
        if ([photo getLocalCachedThumbnailImage]) {
            [self.imageView setImage:[photo getLocalCachedThumbnailImage]];
        }
        else if(photo.thumbImageURL  &&
                ![photo.thumbImageURL isEqualToString:@""]) {
            self.imageView.image = nil;
            [self.imageView setImageWithURL:photo.thumbImageURL];
        }
        else {
            [self.imageView setImage:[UIImage imageNamed:@"bg_noVideo"]];
        }
    }
    else if([photo getLocalCachedImage]) {
        [self.imageView setImage:[photo getLocalCachedImage]];
    }

    self.pageNumberLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)photoIndex + 1,(long)photoCount];
    
    self.canEdit = canEdit;
    
    if (photo.isVideo == YES) {
        self.playButton.hidden = NO;
    }
    else {
        self.playButton.hidden = YES;
    }
}


- (IBAction)back:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(didClickImageCellBackButton)]) {
        [self.delegate didClickImageCellBackButton];
    }
    
}

- (IBAction)more:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickImageCellRightButtonWithPhoto:)]) {
        [self.delegate didClickImageCellRightButtonWithPhoto:self.photo];
    }
}

- (IBAction)playAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickPlayButton:)]) {
        [self.delegate didClickPlayButton:self.photo];
    }
}

#pragma mark - ZoomImageViewDelegate

-(void)didSingleTap{
    
//    if (self.canEdit) {
//        if (self.topView.hidden) {
//            
//            self.topView.hidden = NO;
//            self.topView.alpha = 0;
//            
//            
//            [UIView animateWithDuration:0.3 animations:^{
//                self.topView.alpha = 1;
//            } completion:^(BOOL finished) {
//                
//            }];
//            
//        }else{
//            
//            [UIView animateWithDuration:0.3 animations:^{
//                self.topView.alpha = 0;
//            } completion:^(BOOL finished) {
//                self.topView.hidden = YES;
//            }];
//        }
//    }else{
    if ([self.delegate respondsToSelector:@selector(didClickImageCellBackButton)]) {
        [self.delegate didClickImageCellBackButton];
    }

//    }

}

- (void)hideTopView {
    self.topView.hidden = YES;
}

@end
