//
//  UIImage+Extensions.h
//  LHExtentions
//
//  Created by 李辉 on 15/3/20.
//  Copyright (c) 2015年 org.richard.lihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (qrencode)

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size color:(UIColor*)aQRCodeColor;

@end
