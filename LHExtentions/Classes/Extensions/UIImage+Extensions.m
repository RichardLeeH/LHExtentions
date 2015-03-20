//
//  UIImage+Extensions.m
//  LHExtentions
//
//  Created by 李辉 on 15/3/20.
//  Copyright (c) 2015年 org.richard.lihui. All rights reserved.
//

#import "UIImage+Extensions.h"

#import "qrencode.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
#define kCGImageAlphaPremultipliedLast  (kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast)
#else
#define kCGImageAlphaPremultipliedLast  kCGImageAlphaPremultipliedLast
#endif

enum
{
    qr_margin = 2
};

@implementation UIImage (qrencode)

+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size color:(UIColor*)aQRCodeColor
{
    unsigned char *data = 0;
    int width;
    data = code->data;
    width = code->width;
    float zoom = (double)size / (code->width + 2.0 * qr_margin);
    CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
    
    // draw
    //Richard_Lee deleted @2012.11.14
    //	CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blaceColor].CGColor));
    //using this set fill color
    //    CGContextSetFillColorWithColor(ctx, [[UIColor blueColor] CGColor]);
    if(aQRCodeColor == nil)
    {
        CGContextSetFillColorWithColor(ctx, [[UIColor blackColor] CGColor]);
    }
    else
    {
        CGContextSetFillColorWithColor(ctx, [aQRCodeColor CGColor]);
    }
    
    for(int i = 0; i < width; ++i)
    {
        for(int j = 0; j < width; ++j)
        {
            if(*data & 1)
            {
                rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
                CGContextAddRect(ctx, rectDraw);
            }
            ++data;
        }
    }
    CGContextFillPath(ctx);
}

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size color:(UIColor*)aQRCodeColor
{
    if (![string length])
    {
        return nil;
    }
    
    QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_H, QR_MODE_8, 1);
    if (!code)
    {
        return nil;
    }
    
    float scaleFactor = [[UIScreen mainScreen] scale];
    
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(0, size* scaleFactor, size* scaleFactor, 8, size * scaleFactor * 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size * scaleFactor);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
    
    //解决模糊问题
    CGContextSetShouldAntialias(ctx,NO);
    CGContextSetAllowsAntialiasing(ctx, NO);
    
    CGContextSetShouldSmoothFonts(ctx,NO);
    CGContextSetAllowsFontSmoothing(ctx,NO);
    
    // draw QR on this context
    //	[QRCodeGenerator drawQRCode:code context:ctx size:size];
    [UIImage drawQRCode:code context:ctx size:size * scaleFactor color:aQRCodeColor];
    // get image
    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
    UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
    
    // some releases
    CGContextRelease(ctx);
    CGImageRelease(qrCGImage);
    CGColorSpaceRelease(colorSpace);
    QRcode_free(code);
    
    return qrImage;
}

@end
