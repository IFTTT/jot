//
//  JotTouchBezier.h
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 *  Private class to handle drawing variable-width cubic bezier paths in a JotDrawView.
 */
@interface JotTouchBezier : NSObject

/**
 *  The start point of the cubic bezier path.
 */
@property (nonatomic, assign) CGPoint startPoint;

/**
 *  The end point of the cubic bezier path.
 */
@property (nonatomic, assign) CGPoint endPoint;

/**
 *  The first control point of the cubic bezier path.
 */
@property (nonatomic, assign) CGPoint controlPoint1;

/**
 *  The second control point of the cubic bezier path.
 */
@property (nonatomic, assign) CGPoint controlPoint2;

/**
 *  The starting width of the cubic bezier path.
 */
@property (nonatomic, assign) CGFloat startWidth;

/**
 *  The ending width of the cubic bezier path.
 */
@property (nonatomic, assign) CGFloat endWidth;

/**
 *  The stroke color of the cubic bezier path.
 */
@property (nonatomic, strong) UIColor *strokeColor;

/**
 *  YES if the line is a constant width, NO if variable width.
 */
@property (nonatomic, assign) BOOL constantWidth;

/**
 *  Returns an instance of JotTouchBezier with the given stroke color.
 *
 *  @param color       The color to use for drawing the bezier path.
 *
 *  @return An instance of JotTouchBezier
 */
+ (instancetype)withColor:(UIColor *)color;

/**
 *  Draws the JotTouchBezier in the current graphics context, using the
 *  strokeColor and transitioning from the start width to the end width
 *  along the length of the curve.
 */
- (void)jotDrawBezier;

/**
 *  Draws a single circle at the given point in the current graphics context,
 *  using the current fillColor of the context and the given width.
 *
 *  @param point       The CGPoint to use as the center of the circle to be drawn.
 *  @param width       The diameter of the circle to be drawn at the given point.
 */
+ (void)jotDrawBezierPoint:(CGPoint)point withWidth:(CGFloat)width;

@end
