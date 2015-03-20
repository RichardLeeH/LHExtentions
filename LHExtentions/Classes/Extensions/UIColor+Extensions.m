//
//  UIColor+Extensions.m
//  NSString+Extensions
//
//  Created by 李辉 on 15/3/9.
//  Copyright (c) 2015年 gushiwen.org. All rights reserved.
//  颜色操作扩展

#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

//
// Function   : colorWithFloat
// Description: 根据，浮点数和通道值生成颜色
// Input      : aFloat:浮点数值即 rgb值相同，alpha：通道值
// Output     :
// Return     : UIColor *:返回生成的颜色值
//
+ (UIColor *)colorWithFloat:(CGFloat)aFloat alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:aFloat green:aFloat blue:aFloat alpha:alpha];
}

//
// Function   : colorWithHexString
// Description: 根据十六进制值生成颜色
// Input      : hexString：十六进制字符串
// Output     :
// Return     : UIColor *:返回生成的颜色值
//
+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    return [UIColor colorWithHexString:hexString alpha:1];
}

//
// Function   : colorWithHexString
// Description: 根据十六进制值及通道值生成颜色
// Input      : hexString：十六进制字符串，alpha：通道值
// Output     :
// Return     : UIColor *:返回生成的颜色值
//
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    // #rgb = #rrggbb
    
    if ([hexString hasPrefix:@"#"])
    {
        hexString = [hexString substringFromIndex:1];
    }
    
    if ([hexString length] == 3)
    {
        NSString *oneR = [hexString substringWithRange:NSMakeRange(0, 1)];
        NSString *oneG = [hexString substringWithRange:NSMakeRange(1, 1)];
        NSString *oneB = [hexString substringWithRange:NSMakeRange(2, 1)];
        
        hexString = [NSString stringWithFormat:@"%@%@%@%@%@%@", oneR, oneR, oneG, oneG, oneB, oneB];
    }
    
    if ([hexString length]!=6)
    {
        return nil;
    }
    
    CGFloat red = [UIColor integerValueFromHexString:[hexString substringWithRange:NSMakeRange(0, 2)]];
    CGFloat green = [UIColor integerValueFromHexString:[hexString substringWithRange:NSMakeRange(2, 2)]];
    CGFloat blue = [UIColor integerValueFromHexString:[hexString substringWithRange:NSMakeRange(4, 2)]];
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

//
// Function   : integerValueFromHexString
// Description: 将十六进制字符串转换为数值型
// Input      : hexString：十六进制字符串
// Output     :
// Return     : NSUInteger :返回十六进制字符串转换后的数值
//
+ (NSUInteger)integerValueFromHexString:(NSString *)hexString
{
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned int result;
    [scanner scanHexInt:&result];
    return result;
}


@end
