//
//  WPFZoomImageView.h
//  WPFPageView
//
//  Created by PanFengfeng  on 14-3-19.
//  Copyright (c) 2014年 PanFengfeng . All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZoomImageViewDelegate <NSObject>

-(void)didSingleTap;

@end

@interface WPFZoomImageView : UIView

@property (nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) id <ZoomImageViewDelegate> delegate;

-(void)setImageWithURL:(NSString *)url;

@end
