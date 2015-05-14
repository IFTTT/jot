//
//  UIImage+Jot.m
//  Jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import "UIImage+Jot.h"

@implementation UIImage (Jot)

+ (UIImage *)jotImageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [color setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0.f, 0.f, size.width, size.height));
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return colorImage;
}

@end
