//
//  UIImage+Addition.m
//  OFO
//
//  Created by LiuYong on 2017/10/28.
//  Copyright © 2017年 OFO. All rights reserved.
//

#import "UIImage+Addition.h"

@implementation UIImage (Addition)
+ (UIImage *) imageWithFrame:(CGRect)frame alphe:(CGFloat)alphe {
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIColor *redColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:alphe];
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [redColor CGColor]);
    CGContextFillRect(context, frame);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
