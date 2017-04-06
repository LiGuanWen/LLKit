//
//  WPFZoomImageView.m
//  WPFPageView
//
//  Created by PanFengfeng  on 14-3-19.
//  Copyright (c) 2014年 PanFengfeng . All rights reserved.
//

#import "WPFZoomImageView.h"
#import <UIImageView+WebCache.h>

@interface WPFTouchPassScrollView : UIScrollView

@end

@implementation WPFTouchPassScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.panGestureRecognizer.cancelsTouchesInView = YES;
        self.panGestureRecognizer.delaysTouchesBegan = YES;
        self.panGestureRecognizer.delaysTouchesEnded = YES;
        
        self.pinchGestureRecognizer.cancelsTouchesInView = YES;
        self.pinchGestureRecognizer.delaysTouchesBegan = YES;
        self.pinchGestureRecognizer.delaysTouchesEnded = YES;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nextResponder touchesCancelled:touches withEvent:event];
}

@end

@interface WPFZoomImageView () <UIScrollViewDelegate> {
    UIScrollView            *_internalScrollView;
    UIImageView             *_imageView;
    UITapGestureRecognizer  *_doubleTap;
    UITapGestureRecognizer  *_singleTap;

}


@end

@implementation WPFZoomImageView (Private)

- (CGRect)p_zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = CGRectGetHeight(_internalScrollView.bounds) / scale;
    zoomRect.size.width  = CGRectGetWidth(_internalScrollView.bounds)  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


- (CGPoint)p_contentOffsetForScale:(float)scale withCenter:(CGPoint)center {
    CGPoint contentOffset = CGPointMake(center.x*scale - CGRectGetWidth(_internalScrollView.bounds)/2,
                                        center.y*scale - CGRectGetHeight(_internalScrollView.bounds)/2);
    
    if (contentOffset.x + CGRectGetWidth(_internalScrollView.bounds) > CGRectGetWidth(_imageView.bounds)*scale){
        contentOffset.x = CGRectGetWidth(_imageView.bounds)*scale - CGRectGetWidth(_internalScrollView.bounds);
    }
    
    contentOffset.x = MAX(0, contentOffset.x);
    
    if (contentOffset.y + CGRectGetHeight(_internalScrollView.bounds) > CGRectGetHeight(_imageView.bounds)*scale){
        contentOffset.y = CGRectGetHeight(_imageView.bounds)*scale - CGRectGetHeight(_internalScrollView.bounds);
    }
    
    contentOffset.y = MAX(0, contentOffset.y);
    
    return contentOffset;
}

- (CGSize)p_imageViewSize {
    CGSize imageViewSize = _imageView.image.size;
    imageViewSize.width = MAX(imageViewSize.width, 1.0);
    imageViewSize.height = MAX(imageViewSize.height, 1.0);
    
    CGFloat heightRatio = imageViewSize.height/CGRectGetHeight(_internalScrollView.bounds);
    CGFloat widthRatio = imageViewSize.width/CGRectGetWidth(_internalScrollView.bounds);
    
    if (heightRatio <= 1.0 && widthRatio <= 1.0) { //图片长宽都小于框的长宽
        return imageViewSize;
        
    }else if (heightRatio > widthRatio) { //高度缩放比例较高，以高度比例为准
        return CGSizeMake(imageViewSize.width/heightRatio, imageViewSize.height/heightRatio);
        
    }else { //宽度缩放比例较高，以宽度比例为准
        return CGSizeMake(imageViewSize.width/widthRatio, imageViewSize.height/widthRatio);
        
    }
    
}

static const CGFloat kDefaultMaxScale = 2.0;
- (CGFloat)p_maximumZoomScale {
    CGFloat scaleFactor = kDefaultMaxScale;
    return scaleFactor;
}

- (void)p_setup {
    if (_imageView.image) {
        CGSize newImageSize = [self p_imageViewSize];
        
        _imageView.bounds = CGRectMake(0, 0, newImageSize.width, newImageSize.height);
        _internalScrollView.contentSize = CGSizeMake(MAX(CGRectGetWidth(_imageView.bounds), CGRectGetWidth(_internalScrollView.bounds)),
                                                     MAX(CGRectGetHeight(_imageView.bounds), CGRectGetHeight(_internalScrollView.bounds)));
        _imageView.center = CGPointMake(_internalScrollView.contentSize.width/2.0, _internalScrollView.contentSize.height/2.0);
        _internalScrollView.maximumZoomScale = [self p_maximumZoomScale];
    
    }else {
        _internalScrollView.contentSize =_internalScrollView.bounds.size;
        _imageView.bounds = CGRectZero;
        _internalScrollView.maximumZoomScale = 1.0;
    }
}


@end

@implementation WPFZoomImageView (UIGestureRecognizerAction)

- (void)on_doubleTap:(UITapGestureRecognizer *)aGestureRecognizer {
    CGPoint p = [aGestureRecognizer locationInView:_imageView];
    
    CGFloat scale = [_internalScrollView zoomScale] == 1.0?_internalScrollView.maximumZoomScale:1.0;
    
    CGRect zoomRect = [self p_zoomRectForScale:scale withCenter:p];
    [_internalScrollView zoomToRect:zoomRect animated:YES];
}

- (void)on_singleTap:(UITapGestureRecognizer *)aGestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(didSingleTap)]) {
        [self.delegate didSingleTap];
    }
}

@end


@implementation WPFZoomImageView

@dynamic image;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _internalScrollView = [[WPFTouchPassScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_internalScrollView];
        _internalScrollView.delegate = self;
        _internalScrollView.maximumZoomScale = 2.0;
        _internalScrollView.minimumZoomScale = 1.0;
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_internalScrollView addSubview:_imageView];
        
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(on_doubleTap:)];
        _doubleTap.numberOfTapsRequired = 2;
        _doubleTap.cancelsTouchesInView = YES;
        _doubleTap.delaysTouchesBegan = YES;
        _doubleTap.delaysTouchesEnded = YES;
        [_internalScrollView addGestureRecognizer:_doubleTap];
        
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(on_singleTap:)];
        _singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:_singleTap];
        
        [_singleTap requireGestureRecognizerToFail:_doubleTap];

    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _imageView.image = image;
    [_internalScrollView setZoomScale:1.0 animated:YES];
    [self p_setup];
}



-(void)setImageWithURL:(NSString *)url{
    NSLog(@"%@",url);
    [_internalScrollView setZoomScale:1.0 animated:NO];
    __weak WPFZoomImageView *weakSelf = self;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"placeholder_260_260"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakSelf p_setup];
    }];
}



- (UIImage *)image {
    return _imageView.image;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _internalScrollView.frame = self.bounds;
    [self p_setup];
}

@end

@implementation WPFZoomImageView (UIScrollViewDelegate)

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat offsetX = (CGRectGetWidth(scrollView.bounds) > scrollView.contentSize.width)?
    (CGRectGetWidth(scrollView.bounds) - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (CGRectGetHeight(scrollView.bounds) > scrollView.contentSize.height)?
    (CGRectGetHeight(scrollView.bounds) - scrollView.contentSize.height) * 0.5 : 0.0;
    
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                    scrollView.contentSize.height * 0.5 + offsetY);
    
//    if (!CGPointEqualToPoint(_contentOffsetAfterZoom, CGPointZero)) {
//        scrollView.contentOffset = _contentOffsetAfterZoom;
//        _contentOffsetAfterZoom = CGPointZero;
//    }
}


@end
