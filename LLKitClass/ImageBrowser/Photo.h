//
//  Photo.h
//  JFQMonitor
//
//  Created by ang on 15/5/15.
//  Copyright (c) 2015年 JFQ. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Photo : NSObject

/**
 *  图片ID
 */
@property (nonatomic,assign) NSInteger photoID;

/**
 *  图片本地ID
 */
@property (nonatomic,assign) double localPhotoID;

/**
 *  原图，未经过裁剪
 */
@property (nonatomic,strong) NSString *originalImageURL;

/**
 *  大图，经过裁剪
 */
@property (nonatomic,strong) NSString *bigImageURL;

/**
 *  缩略图
 */
@property (nonatomic,strong) NSString *thumbImageURL;

/**
 *  网络下载后获得的UIImage对象,临时保存
 */
@property (nonatomic,strong) UIImage *cachedImage;

/**
 *  缩略图Key
 */
@property (nonatomic,strong) NSString *thumbnailKey;

/**
 *  是否视频
 */
@property (nonatomic,assign) BOOL isVideo;


-(instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  获得本地缓存图片
 */
- (UIImage*)getLocalCachedImage;

/**
 *  获得本地缓存缩略图
 */
- (UIImage*)getLocalCachedThumbnailImage;

/**
 *  获得网络缓存缩图片
 */
- (UIImage*)getNetworkCachedImage;


/**
 *  清除本地缓存图片、视频
 */
- (void)removeLocalCache;

@end
