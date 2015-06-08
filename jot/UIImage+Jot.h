//
//  UIImage+Jot.h
//  Jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 *  Private category to create single-color background images for
 *  rendering jot's drawing and text sketchpad or whiteboard-style
 *  instead of image annotation-style.
 */
@interface UIImage (Jot)

/**
 *  Creates a single-color image with the given color and size.
 *
 *  @param color The color for the image
 *  @param size  The size the image should be
 *
 *  @return An image of the given color and size
 */
+ (UIImage *)jotImageWithColor:(UIColor *)color size:(CGSize)size;

@end
