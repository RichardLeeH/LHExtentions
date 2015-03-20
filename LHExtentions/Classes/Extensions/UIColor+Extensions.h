//
//  UIColor+Extensions.h
//  NSString+Extensions
//
//  Created by 李辉 on 15/3/9.
//  Copyright (c) 2015年 gushiwen.org. All rights reserved.
//  颜色操作扩展

#import <UIKit/UIKit.h>

@interface UIColor (Extensions)

//
// Function   : colorWithFloat
// Description: 根据，浮点数和通道值生成颜色
// Input      : aFloat:浮点数值即 rgb值相同，alpha：通道值
// Output     :
// Return     : UIColor *:返回生成的颜色值
//
+ (UIColor *)colorWithFloat:(CGFloat)aFloat alpha:(CGFloat)alpha;

//
// Function   : colorWithHexString
// Description: 根据十六进制值生成颜色
// Input      : hexString：十六进制字符串
// Output     :
// Return     : UIColor *:返回生成的颜色值
//
+ (UIColor *)colorWithHexString:(NSString *)hexString;

//
// Function   : colorWithHexString
// Description: 根据十六进制值及通道值生成颜色
// Input      : hexString：十六进制字符串，alpha：通道值
// Output     :
// Return     : UIColor *:返回生成的颜色值
//
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
