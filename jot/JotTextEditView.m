//
//  JotTextEditView.m
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import "JotTextEditView.h"
#import <Masonry/Masonry.h>

@interface JotTextEditView () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *textContainer;
@property (nonatomic, strong) CAGradientLayer *gradientMask;
@property (nonatomic, strong) CAGradientLayer *topGradient;
@property (nonatomic, strong) CAGradientLayer *bottomGradient;

@end

@implementation JotTextEditView

- (instancetype)init
{
    if ((self = [super init])) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _font = [UIFont systemFontOfSize:40.f];
        _fontSize = 40.f;
        
        _textEditingInsets = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
        
        _textContainer = [UIView new];
        self.textContainer.layer.masksToBounds = YES;
        [self addSubview:self.textContainer];
        [self.textContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.equalTo(self);
            make.bottom.equalTo(self).offset(0.f);
        }];
        
        _textView = [UITextView new];
        self.textView.backgroundColor = [UIColor clearColor];
        self.textView.text = self.textString;
        self.textView.keyboardType = UIKeyboardTypeDefault;
        self.textView.returnKeyType = UIReturnKeyDone;
        self.textView.clipsToBounds = NO;
        self.textView.delegate = self;
        [self.textContainer addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.textContainer).insets(_textEditingInsets);
        }];
        
        self.textContainer.hidden = YES;
        self.userInteractionEnabled = NO;
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification *note){
                                                          
                                                          [self.textContainer.layer removeAllAnimations];
                                                          
                                                          CGRect keyboardRectEnd = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
                                                          NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
                                                          
                                                          [self.textContainer mas_updateConstraints:^(MASConstraintMaker *make) {
                                                              make.bottom.equalTo(self).offset(-CGRectGetHeight(keyboardRectEnd));
                                                          }];
                                                          
                                                          [UIView animateWithDuration:duration
                                                                                delay:0.f
                                                                              options:UIViewAnimationOptionBeginFromCurrentState
                                                                           animations:^{
                                                                               [self.textContainer layoutIfNeeded];
                                                                           } completion:nil];
                                                      }];
    }
    
    return self;
}

- (void)dealloc
{
    self.textView.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Properties

- (void)setTextString:(NSString *)textString
{
    if (![_textString isEqualToString:textString]) {
        _textString = textString;
        self.textView.text = textString;
        [self.textView setContentOffset:CGPointZero animated:NO];
    }
}

- (void)setTextEditingInsets:(UIEdgeInsets)textEditingInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_textEditingInsets, textEditingInsets)) {
        _textEditingInsets = textEditingInsets;
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.textContainer).insets(textEditingInsets);
        }];
        [self.textView layoutIfNeeded];
        [self.textView setContentOffset:CGPointZero animated:NO];
    }
}

- (void)setFont:(UIFont *)font
{
    if (_font != font) {
        _font = font;
        self.textView.font = [font fontWithSize:_fontSize];
    }
}

- (void)setFontSize:(CGFloat)fontSize
{
    if (_fontSize != fontSize) {
        _fontSize = fontSize;
        self.textView.font = [_font fontWithSize:fontSize];
    }
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    if (_textAlignment != textAlignment) {
        _textAlignment = textAlignment;
        self.textView.textAlignment = textAlignment;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    if (_textColor != textColor) {
        _textColor = textColor;
        self.textView.textColor = textColor;
    }
}

- (void)setClipBoundsToEditingInsets:(BOOL)clipBoundsToEditingInsets
{
    if (_clipBoundsToEditingInsets != clipBoundsToEditingInsets) {
        _clipBoundsToEditingInsets = clipBoundsToEditingInsets;
        _textView.clipsToBounds = clipBoundsToEditingInsets;
        [self setupGradientMask];
    }
}

- (void)setIsEditing:(BOOL)isEditing
{
    if (_isEditing != isEditing) {
        _isEditing = isEditing;
        self.textContainer.hidden = !isEditing;
        self.userInteractionEnabled = isEditing;
        if (isEditing) {
            self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5f];
            [self.textView becomeFirstResponder];
        } else {
            self.backgroundColor = [UIColor clearColor];
            _textString = self.textView.text;
            [self.textView resignFirstResponder];
            if ([self.delegate respondsToSelector:@selector(jotTextEditViewFinishedEditingWithNewTextString:)]) {
                [self.delegate jotTextEditViewFinishedEditingWithNewTextString:_textString];
            }
        }
    }
}

#pragma mark - Gradient Mask

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupGradientMask];
}

- (void)setupGradientMask
{
    if (!self.clipBoundsToEditingInsets) {
        self.textContainer.layer.mask = self.gradientMask;
        
        CGFloat percentTopOffset = self.textEditingInsets.top / CGRectGetHeight(self.textContainer.bounds);
        CGFloat percentBottomOffset = self.textEditingInsets.bottom / CGRectGetHeight(self.textContainer.bounds);
        
        self.gradientMask.locations = @[ @(0.f * percentTopOffset),
                                         @(0.8f * percentTopOffset),
                                         @(0.9f * percentTopOffset),
                                         @(1.f * percentTopOffset),
                                         @(1.f - (1.f * percentBottomOffset)),
                                         @(1.f - (0.9f * percentBottomOffset)),
                                         @(1.f - (0.8f * percentBottomOffset)),
                                         @(1.f - (0.f * percentBottomOffset)) ];
        
        self.gradientMask.frame = CGRectMake(0.f,
                                             0.f,
                                             CGRectGetWidth(self.textContainer.bounds),
                                             CGRectGetHeight(self.textContainer.bounds));
    } else {
        self.textContainer.layer.mask = nil;
    }
}

- (CAGradientLayer *)gradientMask
{
    if (!_gradientMask) {
        _gradientMask = [CAGradientLayer layer];
        _gradientMask.colors = @[ (id)[UIColor colorWithWhite:1.f alpha:0.f].CGColor,
                                  (id)[UIColor colorWithWhite:1.f alpha:0.4f].CGColor,
                                  (id)[UIColor colorWithWhite:1.f alpha:0.7f].CGColor,
                                  (id)[UIColor colorWithWhite:1.f alpha:1.f].CGColor,
                                  (id)[UIColor colorWithWhite:1.f alpha:1.f].CGColor,
                                  (id)[UIColor colorWithWhite:1.f alpha:0.7f].CGColor,
                                  (id)[UIColor colorWithWhite:1.f alpha:0.4f].CGColor,
                                  (id)[UIColor colorWithWhite:1.f alpha:0.f].CGColor
                                  ];
    }
    
    return _gradientMask;
}

#pragma mark - Text Editing

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    if ([text isEqualToString: @"\n"]) {
        self.isEditing = NO;
        return NO;
    }
    
    if (textView.text.length + (text.length - range.length) > 70) {
        return NO;
    }
    
    if ([text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location != NSNotFound) {
        return NO;
    }
    
    return YES;
}

@end
