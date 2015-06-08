//
//  JotDrawView.h
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 *  Private class to handle touch drawing. Change the properties
 *  in a JotViewController instance to configure this private class.
 */
@interface JotDrawView : UIView

/**
 *  Set to YES if you want the stroke width to be constant,
 *  NO if the stroke width should vary depending on drawing
 *  speed.
 *
 *  @note Set drawingConstantStrokeWidth in JotViewController
 *  to control this setting.
 */
@property (nonatomic, assign) BOOL constantStrokeWidth;

/**
 *  Sets the stroke width if constantStrokeWidth is true,
 *  or sets the base strokeWidth for variable drawing paths.
 *
 *  @note Set drawingStrokeWidth in JotViewController
 *  to control this setting.
 */
@property (nonatomic, assign) CGFloat strokeWidth;

/**
 *  Sets the stroke color. Each path can have its own stroke color.
 *
 *  @note Set drawingColor in JotViewController
 *  to control this setting.
 */
@property (nonatomic, strong) UIColor *strokeColor;

/**
 *  Clears all paths from the drawing, giving a blank slate.
 *
 *  @note Call clearDrawing or clearAll in JotViewController
 *  to trigger this method.
 */
- (void)clearDrawing;

/**
 *  Tells the JotDrawView to handle a touchesBegan event.
 *
 *  @param touchPoint The point in this view's coordinate
 *  system where the touch began.
 *
 *  @note This method is triggered by the JotDrawController's
 *  touchesBegan event.
 */
- (void)drawTouchBeganAtPoint:(CGPoint)touchPoint;

/**
 *  Tells the JotDrawView to handle a touchesMoved event.
 *
 *  @param touchPoint The point in this view's coordinate
 *  system where the touch moved.
 *
 *  @note This method is triggered by the JotDrawController's
 *  touchesMoved event.
 */
- (void)drawTouchMovedToPoint:(CGPoint)touchPoint;

/**
 *  Tells the JotDrawView to handle a touchesEnded event.
 *
 *  @note This method is triggered by the JotDrawController's
 *  touchesEnded event.
 */
- (void)drawTouchEnded;

/**
 *  Overlays the drawing on the given background image, rendering
 *  the drawing at the full resolution of the image.
 *
 *  @param image The background image to draw on top of.
 *
 *  @return An image of the rendered drawing on the background image.
 *
 *  @note Call drawOnImage: in JotViewController
 *  to trigger this method.
 */
- (UIImage *)drawOnImage:(UIImage *)image;

/**
 *  Renders the drawing at full resolution for the given size.
 *
 *  @param size The size of the image to return.
 *
 *  @return An image of the rendered drawing.
 *
 *  @note Call renderWithSize: in JotViewController
 *  to trigger this method.
 */
- (UIImage *)renderDrawingWithSize:(CGSize)size;

@end
