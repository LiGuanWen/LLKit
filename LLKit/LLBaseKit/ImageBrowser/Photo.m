//
//  Photo.m
//  JFQMonitor
//
//  Created by ang on 15/5/15.
//  Copyright (c) 2015年 JFQ. All rights reserved.
//

#import "Photo.h"
#import "LocalImageCache.h"

@interface Photo ()


@end

@implementation Photo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.localPhotoID = [[NSDate date] timeIntervalSince1970];
    }
    return self;
}

-(instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.photoID = [[dict valueForKey:@"img_id"] integerValue];
        self.localPhotoID = [[NSDate date] timeIntervalSince1970];
        self.originalImageURL = [dict valueForKey:@"img_file"];
        self.bigImageURL = [self insertString:@"_l" orginalString:self.originalImageURL type:[dict valueForKey:@"img_type"]];
        self.thumbImageURL = [self insertString:@"_s" orginalString:self.originalImageURL type:[dict valueForKey:@"img_type"]];
    }
    return self;
}

// 获取特定图片地址
-(NSString*)insertString:(NSString*)insertedString orginalString:(NSString*)originalString type:(NSString*)fileType {
    if (insertedString == nil || originalString == nil || fileType == nil) {
        return @"";
    }
    
    // 图片后缀，包含.符号 ex:.gif  .jpg
    NSString *suffixString = [NSString stringWithFormat:@".%@",fileType];
    // 后缀的范围长度
    NSRange suffixStringRange = [originalString rangeOfString:suffixString];
    
    // 取出后缀前的字符
    NSString *clipString = [originalString substringToIndex:suffixStringRange.location];
    
    // 结果字符串
    NSString *resultString = [NSString stringWithFormat:@"%@%@%@",clipString,insertedString,suffixString];
    
    return resultString;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.photoID forKey:@"photoID"];
    [aCoder encodeDouble:self.localPhotoID forKey:@"localPhotoID"];
    [aCoder encodeObject:self.originalImageURL forKey:@"originalImageURL"];
    [aCoder encodeObject:self.bigImageURL forKey:@"bigImageURL"];
    [aCoder encodeObject:self.thumbImageURL forKey:@"thumbImageURL"];
    [aCoder encodeObject:self.thumbnailKey forKey:@"thumbnailKey"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.photoID = [aDecoder decodeIntegerForKey:@"photoID"];
        self.localPhotoID = [aDecoder decodeDoubleForKey:@"localPhotoID"];
        self.originalImageURL = [aDecoder decodeObjectForKey:@"originalImageURL"];
        self.bigImageURL = [aDecoder decodeObjectForKey:@"bigImageURL"];
        self.thumbImageURL = [aDecoder decodeObjectForKey:@"thumbImageURL"];
    }
    return self;
}

- (UIImage*)getLocalCachedImage {
    UIImage *cachedImage =
    [[LocalImageCache sharedImageCache] imageFromDiskCacheForKey:@(self.localPhotoID).stringValue];
    return cachedImage;
}

- (UIImage*)getLocalCachedThumbnailImage {
    UIImage *cachedImage =
    [[LocalImageCache sharedImageCache] imageFromDiskCacheForKey:self.thumbnailKey];
    return cachedImage;
}

- (UIImage*)getNetworkCachedImage {
    UIImage *cachedImage =
    [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:self.originalImageURL];
    return cachedImage;
}

- (NSString*)thumbnailKey {
    if (_localPhotoID > 0) {
        return [NSString stringWithFormat:@"%lf_thumb",_localPhotoID];
    }
    else {
        return _thumbnailKey;
    }
}

- (void)removeLocalCache {
    // 清除缓存图
    [[LocalImageCache sharedImageCache] removeImageForKey:@(self.localPhotoID).stringValue];
    // 清除缩略图
    [[LocalImageCache sharedImageCache] removeImageForKey:self.thumbnailKey];
}


@end

