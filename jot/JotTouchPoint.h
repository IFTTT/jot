//
//  JotTouchPoint.h
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 *  Private class to handle timestamped touch events for drawing
 *  variable-width bezier curves in a JotDrawView, and for 
 *  representing single-touch-point events for drawing dots of
 *  a given width and color in the JotDrawView.
 */
@interface JotTouchPoint : NSObject

/**
 *  The CGPoint where the touch event occurred.
 */
@property (nonatomic, assign) CGPoint point;

/**
 *  The timestamp of the touch event, used later to calculate the
 *  speed that a variable-width bezier curve was drawn with so that
 *  the stroke width can be made thinner or wider accordingly.
 */
@property (nonatomic, strong) NSDate *timestamp;

/**
 *  The stroke color to use for drawing this as a single-touch-point dot.
 */
@property (nonatomic, strong) UIColor *strokeColor;

/**
 *  The stroke width to use for drawing this as a single-touch-point dot.
 */
@property (nonatomic, assign) CGFloat strokeWidth;

/**
 *  Returns an instance of JotTouchPoint with the given CGPoint
 *
 *  @param point The CGPoint where the touch event occurred
 *
 *  @return An instance of JotTouchPoint
 */
+ (instancetype)withPoint:(CGPoint)point;

/**
 *  Calculates the velocity between two points, based on their locations
 *  and the time interval between them.
 *
 *  @param point The point from which to calculate the velocity of the touch movement.
 *
 *  @return The velocity between the two points
 */
- (CGFloat)velocityFromPoint:(JotTouchPoint *)point;

/**
 *  The CGPoint representing the location of the touch event for this JotTouchPoint.
 *
 *  @return The CGPoint value of this JotTouchPoint
 */
- (CGPoint)CGPointValue;

@end
