//
//  UIColor+Config.m
//  News
//
//  Created by Lilong on 2016/12/13.
//  Copyright © 2016年 李龙. All rights reserved.
//

#import "UIColor+Config.h"
#import "YYKit.h"
@implementation UIColor (Config)

+ (UIColor *)colorWithHexString:(NSString *)str alpha:(CGFloat)alpha
{
    if (str) {
        //删除字符串中的空格
        NSString *cString = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        // String should be 6 or 8 characters
        if ([cString length] < 6)
        {
            return [UIColor clearColor];
        }
        // strip 0X if it appears
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        if ([cString hasPrefix:@"0X"])
        {
            cString = [cString substringFromIndex:2];
        }
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        if ([cString hasPrefix:@"#"])
        {
            cString = [cString substringFromIndex:1];
        }
        if ([cString length] != 6)
        {
            return [UIColor clearColor];
        }
        
        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        //r
        NSString *rString = [cString substringWithRange:range];
        //g
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        //b
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
    }
    return nil;
}

+(UIColor *)listSeparateColor {
    return [UIColor colorWithHexString:@"eeeeee" alpha:0.71f];
}

+ (UIColor *)defaulViewBackgroundColor
{
    return [UIColor colorWithHexString:@"#F8F8F8"];
}



@end
