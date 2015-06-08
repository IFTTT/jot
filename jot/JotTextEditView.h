//
//  JotTextEditView.h
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol JotTextEditViewDelegate;

/**
 *  Private class to handle text editing. Change the properties
 *  in a JotViewController instance to configure this private class.
 */
@interface JotTextEditView : UIView

/**
 *  The delegate of the JotTextEditView, which receives an update
 *  when the JotTextEditView is finished editing text, with the
 *  revised textString.
 */
@property (nonatomic, weak) id <JotTextEditViewDelegate> delegate;

/**
 *  Whether or not the JotTextEditView is actively in edit mode.
 *  This property controls whether or not the keyboard is displayed
 *  and the JotTextEditView is visible.
 *
 *  @note Set the JotViewController state to JotViewStateEditingText
 *  to turn on editing mode in JotTextEditView.
 */
@property (nonatomic, assign) BOOL isEditing;

/**
 *  The text string the JotTextEditView is currently displaying.
 *
 *  @note Set textString in JotViewController
 *  to control or read this property.
 */
@property (nonatomic, strong) NSString *textString;

/**
 *  The color of the text displayed in the JotTextEditView.
 *
 *  @note Set textColor in JotViewController
 *  to control this property.
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 *  The font of the text displayed in the JotTextEditView.
 *
 *  @note Set font in JotViewController to control this property.
 *  To change the default size of the font, you must also set the
 *  fontSize property to the desired font size.
 */
@property (nonatomic, strong) UIFont *font;

/**
 *  The font size of the text displayed in the JotTextEditView.
 *
 *  @note Set fontSize in JotViewController to control this property,
 *  which overrides the size of the font property.
 */
@property (nonatomic, assign) CGFloat fontSize;

/**
 *  The alignment of the text displayed in the JotTextEditView.
 *
 *  @note Set textAlignment in JotViewController to control this property.
 */
@property (nonatomic, assign) NSTextAlignment textAlignment;

/**
 *  The view insets of the text displayed in the JotTextEditView. By default,
 *  the text that extends beyond the insets of the text input view will fade out
 *  with a gradient to the edges of the JotTextEditView. If clipBoundsToEditingInsets
 *  is true, then the text will be clipped at the inset instead of fading out.
 *
 *  @note Set textEditingInsets in JotViewController to control this property.
 */
@property (nonatomic, assign) UIEdgeInsets textEditingInsets;

/**
 *  By default, clipBoundsToEditingInsets is false, and the text that extends 
 *  beyond the insets of the text input view will fade out with a gradient 
 *  to the edges of the JotTextEditView. If clipBoundsToEditingInsets is true, 
 *  then the text will be clipped at the inset instead of fading out.
 *
 *  @note Set clipBoundsToEditingInsets in JotViewController to control this property.
 */
@property (nonatomic, assign) BOOL clipBoundsToEditingInsets;

@end


@protocol JotTextEditViewDelegate <NSObject>

/**
 *  Called whenever the JotTextEditView ends text editing (keyboard entry) mode.
 *
 *  @param textString    The new text string after editing
 */
- (void)jotTextEditViewFinishedEditingWithNewTextString:(NSString *)textString;

@end
