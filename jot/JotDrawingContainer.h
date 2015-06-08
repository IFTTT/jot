//
//  JotDrawingContainer.h
//  jot
//
//  Created by Laura Skelton on 5/12/15.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol JotDrawingContainerDelegate;

@interface JotDrawingContainer : UIView

/**
 *  The delegate of the JotDrawingContainer, which receives
 *  updates about touch events in the drawing container.
 */
@property (nonatomic, weak) id <JotDrawingContainerDelegate> delegate;

@end

@protocol JotDrawingContainerDelegate <NSObject>

/**
 *  Tells the delegate to handle a touchesBegan event.
 *
 *  @param touchPoint The point in this view's coordinate
 *  system where the touch began.
 */
- (void)jotDrawingContainerTouchBeganAtPoint:(CGPoint)touchPoint;

/**
 *  Tells the delegate to handle a touchesMoved event.
 *
 *  @param touchPoint The point in this view's coordinate
 *  system to which the touch moved.
 */
- (void)jotDrawingContainerTouchMovedToPoint:(CGPoint)touchPoint;

/**
 *  Tells the delegate to handle a touchesEnded event.
 */
- (void)jotDrawingContainerTouchEnded;

@end
