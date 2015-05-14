//
//  JotConstantWidthBezier.h
//  jot
//
//  Created by Laura Skelton on 5/6/15.
//
//

@import Foundation;
@import UIKit;

/**
 *  Private class to handle drawing constant-width bezier paths in a JotDrawView.
 */
@interface JotConstantWidthBezier : NSObject

/**
 *  The bezierPath that this JotConstantWidthBezier will draw.
 */
@property (nonatomic, strong) UIBezierPath *bezierPath;

/**
 *  The color that this JotConstantWidthBezier will use for drawing its path.
 */
@property (nonatomic, strong, readonly) UIColor *strokeColor;

/**
 *  Returns an instance of JotConstantWidthBezier with the given strokeWidth
 *  and stroke color
 *
 *  @param strokeWidth The stroke width to use for drawing the bezier path.
 *  @param color       The color to use for drawing the bezier path.
 *
 *  @return An instance of JotConstantWidthBezier
 */
+ (instancetype)withStrokeWidth:(CGFloat)strokeWidth color:(UIColor *)color;

/**
 *  Draws the JotConstantWidthBezier's bezier path in the current graphics context,
 *  using the strokeColor and strokeWidth the JotConstantWidthBezier was created with.
 */
- (void)jotDrawConstantWidthBezier;

/**
 *  Tells the JotConstantWidthBezier's bezier path to move to the given point.
 *
 *  @param point The CGPoint to which the bezier path should move.
 */
- (void)moveToPoint:(CGPoint)point;

/**
 *  Tells the JotConstantWidthBezier's bezier path to add a line to the given point.
 *
 *  @param point The CGPoint to which the bezier path should add a line.
 */
- (void)addLineToPoint:(CGPoint)point;

@end
