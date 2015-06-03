//
//  JotViewController.h
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 *  The possible states of the JotViewController
 */
typedef NS_ENUM(NSUInteger, JotViewState){
    /**
     *  The default state, which does not allow
     *  any touch interactions.
     */
    JotViewStateDefault,
    /**
     *  The drawing state, where drawing with touch
     *  gestures will create colored lines in the view.
     */
    JotViewStateDrawing,
    /**
     *  The text state, where pinch, pan, and rotate
     *  gestures will manipulate the displayed text, and
     *  a tap gesture will switch to text editing mode.
     */
    JotViewStateText,
    /**
     *  The text editing state, where the contents of
     *  the text string can be edited with the keyboard.
     */
    JotViewStateEditingText
};

@import UIKit;
#import "JotDrawingContainer.h"

@protocol JotViewControllerDelegate;

/**
 *  Public class for you to use to create a jot view! Import <jot.h>
 *  into your view controller, then create an instance of JotViewController
 *  and add it as a child of your view controller. Set the state of the
 *  JotViewController to switch between manipulating text and drawing.
 *
 *  @note You will be able to see your view controller's view through
 *  the jot view, so you can display the jot view above either a colored
 *  background for a sketchpad/whiteboard-like interface, or above a photo
 *  for a photo annotation interface.
 */
@interface JotViewController : UIViewController

/**
 *  The delegate of the JotViewController instance.
 */
@property (nonatomic, weak) id <JotViewControllerDelegate> delegate;

/**
 *  The state of the JotViewController. Change the state between JotViewStateDrawing
 *  and JotViewStateText in response to your own editing controls to toggle between
 *  the different modes. Tapping while in JotViewStateText will automatically switch
 *  to JotViewStateEditingText, and tapping the keyboard's Done button will automatically
 *  switch back to JotViewStateText.
 *
 *  @note The JotViewController's delegate will get updates when it enters and exits
 *  text editing mode, in case you need to update your interface to reflect this.
 */
@property (nonatomic, assign) JotViewState state;

/**
 *  The font of the text displayed in the JotTextView and JotTextEditView.
 *
 *  @note To change the default size of the font, you must also set the
 *  fontSize property to the desired font size.
 */
@property (nonatomic, strong) UIFont *font;

/**
 *  The initial font size of the text displayed in the JotTextView before pinch zooming,
 *  and the fixed font size of the JotTextEditView.
 *
 *  @note This property overrides the size of the font property.
 */
@property (nonatomic, assign) CGFloat fontSize;

/**
 *  The color of the text displayed in the JotTextView and the JotTextEditView.
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 *  The text string the JotTextView and JotTextEditView are displaying.
 */
@property (nonatomic, strong) NSString *textString;

/**
 *  The alignment of the text displayed in the JotTextView, which only
 *  applies if fitOriginalFontSizeToViewWidth is true, and the alignment of the
 *  text displayed in the JotTextEditView regardless of other settings.
 */
@property (nonatomic, assign) NSTextAlignment textAlignment;

/**
 *  Sets the stroke color for drawing. Each drawing path can have its own stroke color.
 */
@property (nonatomic, strong) UIColor *drawingColor;

/**
 *  Sets the stroke width for drawing if constantStrokeWidth is true, or sets
 *  the base strokeWidth for variable drawing paths constantStrokeWidth is false.
 */
@property (nonatomic, assign) CGFloat drawingStrokeWidth;

/**
 *  Set to YES if you want the stroke width for drawing to be constant,
 *  NO if the stroke width should vary depending on drawing speed.
 */
@property (nonatomic, assign) BOOL drawingConstantStrokeWidth;

/**
 *  The view insets of the text displayed in the JotTextEditView. By default,
 *  the text that extends beyond the insets of the text input view will fade out
 *  with a gradient to the edges of the JotTextEditView. If clipBoundsToEditingInsets
 *  is true, then the text will be clipped at the inset instead of fading out.
 */
@property (nonatomic, assign) UIEdgeInsets textEditingInsets;

/**
 *  The initial insets of the text displayed in the JotTextView, which only
 *  applies if fitOriginalFontSizeToViewWidth is true. If fitOriginalFontSizeToViewWidth
 *  is true, then initialTextInsets sets the initial insets of the displayed text relative to the
 *  full size of the JotTextView. The user can resize, move, and rotate the text from that
 *  starting position, but the overall proportions of the text will stay the same.
 *
 *  @note This will be ignored if fitOriginalFontSizeToViewWidth is false.
 */
@property (nonatomic, assign) UIEdgeInsets initialTextInsets;

/**
 *  If fitOriginalFontSizeToViewWidth is true, then the text will wrap to fit within the width
 *  of the JotTextView, with the given initialTextInsets, if any. The layout will reflect
 *  the textAlignment property as well as the initialTextInsets property. If this is false,
 *  then the text will be displayed as a single line, and will ignore any initialTextInsets and
 *  textAlignment settings
 */
@property (nonatomic, assign) BOOL fitOriginalFontSizeToViewWidth;

/**
 *  By default, clipBoundsToEditingInsets is false, and the text that extends
 *  beyond the insets of the text input view in the JotTextEditView will fade out with
 *  a gradient to the edges of the JotTextEditView. If clipBoundsToEditingInsets is true,
 *  then the text will be clipped at the inset instead of fading out in the JotTextEditView.
 */
@property (nonatomic, assign) BOOL clipBoundsToEditingInsets;


@property (nonatomic, strong, readonly) JotDrawingContainer *drawingContainer;

/**
 *  Clears all paths from the drawing in and sets the text to an empty string, giving a blank slate.
 */
- (void)clearAll;

/**
 *  Clears only the drawing, leaving the text alone.
 */
- (void)clearDrawing;

/**
 *  Clears only the text, leaving the drawing alone.
 */
- (void)clearText;

/**
 *  Overlays the drawing and text on the given background image at the full
 *  resolution of the image.
 *
 *  @param image The background image to draw on top of.
 *
 *  @return An image of the rendered drawing and text on the background image.
 */
- (UIImage *)drawOnImage:(UIImage *)image;

/**
 *  Renders the drawing and text at the view's size with a transparent background.
 *
 *  @return An image of the rendered drawing and text.
 */
- (UIImage *)renderImage;

/**
 *  Renders the drawing and text at the view's size with a colored background.
 *
 *  @return An image of the rendered drawing and text on a colored background.
 */
- (UIImage *)renderImageOnColor:(UIColor *)color;

/**
 *  Renders the drawing and text at the view's size multiplied by the given scale
 *  with a transparent background.
 *
 *  @return An image of the rendered drawing and text.
 */
- (UIImage *)renderImageWithScale:(CGFloat)scale;

/**
 *  Renders the drawing and text at the view's size multiplied by the given scale
 *  with a colored background.
 *
 *  @return An image of the rendered drawing and text on a colored background.
 */
- (UIImage *)renderImageWithScale:(CGFloat)scale onColor:(UIColor *)color;

@end

@protocol JotViewControllerDelegate <NSObject>

@optional

/**
 *  Called whenever the JotViewController begins or ends text editing (keyboard entry) mode.
 *
 *  @param jotViewController The draw text view controller
 *  @param isEditing    YES if entering edit (keyboard text entry) mode, NO if exiting edit mode
 */
- (void)jotViewController:(JotViewController *)jotViewController isEditingText:(BOOL)isEditing;

@end
