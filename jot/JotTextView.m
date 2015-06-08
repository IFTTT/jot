//
//  JotTextView.m
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import "JotTextView.h"

@interface JotTextView ()

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *textEditingContainer;
@property (nonatomic, strong) UITextView *textEditingView;
@property (nonatomic, assign) CGAffineTransform referenceRotateTransform;
@property (nonatomic, assign) CGAffineTransform currentRotateTransform;
@property (nonatomic, assign) CGPoint referenceCenter;
@property (nonatomic, strong) UIPinchGestureRecognizer *activePinchRecognizer;
@property (nonatomic, strong) UIRotationGestureRecognizer *activeRotationRecognizer;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGRect labelFrame;

@end

@implementation JotTextView

- (instancetype)init
{
    if ((self = [super init])) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _initialTextInsets = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
        
        _fontSize = 60.f;
        _scale = 1.f;
        _font = [UIFont systemFontOfSize:self.fontSize];
        _textAlignment = NSTextAlignmentCenter;
        _textColor = [UIColor whiteColor];
        _textString = @"";
        _textLabel = [UILabel new];
        if (self.fitOriginalFontSizeToViewWidth) {
            self.textLabel.numberOfLines = 0;
        }
        self.textLabel.font = self.font;
        self.textLabel.textColor = self.textColor;
        self.textLabel.textAlignment = self.textAlignment;
        self.textLabel.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds),
                                            CGRectGetMidY([UIScreen mainScreen].bounds));
        self.referenceCenter = CGPointZero;
        [self sizeLabel];
        [self addSubview:self.textLabel];
        
        _referenceRotateTransform = CGAffineTransformIdentity;
        _currentRotateTransform = CGAffineTransformIdentity;
        
        self.userInteractionEnabled = NO;
    }
    
    return self;
}

#pragma mark - Layout Subviews

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (CGPointEqualToPoint(self.referenceCenter, CGPointZero)) {
        self.textLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                            CGRectGetMidY(self.bounds));
    }
}

#pragma mark - Undo

- (void)clearText
{
    self.scale = 1.f;
    self.textLabel.transform = CGAffineTransformIdentity;
    self.textString = @"";
}

#pragma mark - Properties

- (void)setTextString:(NSString *)textString
{
    if (![_textString isEqualToString:textString]) {
        _textString = textString;
        CGPoint center = self.textLabel.center;
        self.textLabel.text = textString;
        [self sizeLabel];
        self.textLabel.center = center;
    }
}

- (void)setScale:(CGFloat)scale
{
    if (_scale != scale) {
        _scale = scale;
        self.textLabel.transform = CGAffineTransformIdentity;
        CGPoint labelCenter = self.textLabel.center;
        CGRect scaledLabelFrame = CGRectMake(0.f,
                                             0.f,
                                             CGRectGetWidth(_labelFrame) * _scale * 1.05f,
                                             CGRectGetHeight(_labelFrame) * _scale * 1.05f);
        CGFloat currentFontSize = self.fontSize * _scale;
        self.textLabel.font = [self.font fontWithSize:currentFontSize];
        self.textLabel.frame = scaledLabelFrame;
        self.textLabel.center = labelCenter;
        self.textLabel.transform = self.currentRotateTransform;
    }
}

- (void)setFontSize:(CGFloat)fontSize
{
    if (_fontSize != fontSize) {
        _fontSize = fontSize;
        [self adjustLabelFont];
    }
}

- (void)setFont:(UIFont *)font
{
    if (_font != font) {
        _font = font;
        [self adjustLabelFont];
    }
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    if (_textAlignment != textAlignment) {
        _textAlignment = textAlignment;
        self.textLabel.textAlignment = self.textAlignment;
        [self sizeLabel];
    }
}

- (void)setInitialTextInsets:(UIEdgeInsets)initialTextInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_initialTextInsets, initialTextInsets)) {
        _initialTextInsets = initialTextInsets;
        [self sizeLabel];
    }
}

- (void)setFitOriginalFontSizeToViewWidth:(BOOL)fitOriginalFontSizeToViewWidth
{
    if (_fitOriginalFontSizeToViewWidth != fitOriginalFontSizeToViewWidth) {
        _fitOriginalFontSizeToViewWidth = fitOriginalFontSizeToViewWidth;
        self.textLabel.numberOfLines = (fitOriginalFontSizeToViewWidth ? 0 : 1);
        [self sizeLabel];
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    if (_textColor != textColor) {
        _textColor = textColor;
        self.textLabel.textColor = textColor;
    }
}

- (void)setLabelFrame:(CGRect)labelFrame
{
    if (!CGRectEqualToRect(_labelFrame, labelFrame)) {
        _labelFrame = labelFrame;
        CGPoint labelCenter = self.textLabel.center;
        CGRect scaledLabelFrame = CGRectMake(0.f,
                                             0.f,
                                             CGRectGetWidth(_labelFrame) * _scale * 1.05f,
                                             CGRectGetHeight(_labelFrame) * _scale * 1.05f);
        CGAffineTransform labelTransform = self.textLabel.transform;
        self.textLabel.transform = CGAffineTransformIdentity;
        self.textLabel.frame = scaledLabelFrame;
        self.textLabel.transform = labelTransform;
        self.textLabel.center = labelCenter;
    }
}

#pragma mark - Format Text Label

- (void)adjustLabelFont
{
    CGFloat currentFontSize = _fontSize * _scale;
    CGPoint center = self.textLabel.center;
    self.textLabel.font = [_font fontWithSize:currentFontSize];
    [self sizeLabel];
    self.textLabel.center = center;
}

- (void)sizeLabel
{
    UILabel *temporarySizingLabel = [UILabel new];
    temporarySizingLabel.text = _textString;
    temporarySizingLabel.font = [_font fontWithSize:_fontSize];
    temporarySizingLabel.textAlignment = _textAlignment;
    
    CGRect insetViewRect;
    
    if (_fitOriginalFontSizeToViewWidth) {
        temporarySizingLabel.numberOfLines = 0;
        insetViewRect = CGRectInset(self.bounds,
                                           _initialTextInsets.left + _initialTextInsets.right,
                                           _initialTextInsets.top + _initialTextInsets.bottom);
    } else {
        temporarySizingLabel.numberOfLines = 1;
        insetViewRect = CGRectMake(0.f, 0.f, CGFLOAT_MAX, CGFLOAT_MAX);
    }
    
    CGSize originalSize = [temporarySizingLabel sizeThatFits:insetViewRect.size];
    temporarySizingLabel.frame = CGRectMake(0.f,
                                            0.f,
                                            originalSize.width * 1.05f,
                                            originalSize.height * 1.05f);
    temporarySizingLabel.center = self.textLabel.center;
    self.labelFrame = temporarySizingLabel.frame;
}

#pragma mark - Gestures

- (void)handlePanGesture:(UIGestureRecognizer *)recognizer
{
    if (![recognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return;
    }
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            self.referenceCenter = self.textLabel.center;
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            CGPoint panTranslation = [(UIPanGestureRecognizer *)recognizer translationInView:self];
            self.textLabel.center = CGPointMake(self.referenceCenter.x + panTranslation.x,
                                                self.referenceCenter.y + panTranslation.y);;
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            self.referenceCenter = self.textLabel.center;
            break;
        }
            
        default:
            break;
    }
}

- (void)handlePinchOrRotateGesture:(UIGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            if ([recognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
                self.currentRotateTransform = self.referenceRotateTransform;
                self.activeRotationRecognizer = (UIRotationGestureRecognizer *)recognizer;
            } else {
                self.activePinchRecognizer = (UIPinchGestureRecognizer *)recognizer;
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
            
            CGAffineTransform currentTransform = self.referenceRotateTransform;
            
            if ([recognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
                self.currentRotateTransform = [self.class applyRecognizer:recognizer toTransform:self.referenceRotateTransform];
            }
            
            currentTransform = [self.class applyRecognizer:self.activePinchRecognizer toTransform:currentTransform];
            currentTransform = [self.class applyRecognizer:self.activeRotationRecognizer toTransform:currentTransform];
            
            self.textLabel.transform = currentTransform;
            
            break;
        }
            
        case UIGestureRecognizerStateEnded: {
            if ([recognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
                
                self.referenceRotateTransform = [self.class applyRecognizer:recognizer toTransform:self.referenceRotateTransform];
                self.currentRotateTransform = self.referenceRotateTransform;
                self.activeRotationRecognizer = nil;
                
            } else if ([recognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
                
                self.scale *= [(UIPinchGestureRecognizer *)recognizer scale];
                self.activePinchRecognizer = nil;
            }
            
            break;
        }
            
        default:
            break;
    }
}

+ (CGAffineTransform)applyRecognizer:(UIGestureRecognizer *)recognizer toTransform:(CGAffineTransform)transform
{
    if (!recognizer
        || !([recognizer isKindOfClass:[UIRotationGestureRecognizer class]]
             || [recognizer isKindOfClass:[UIPinchGestureRecognizer class]])) {
        return transform;
    }
    
    if ([recognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
        
        return CGAffineTransformRotate(transform, [(UIRotationGestureRecognizer *)recognizer rotation]);
    }
    
    CGFloat scale = [(UIPinchGestureRecognizer *)recognizer scale];
    return CGAffineTransformScale(transform, scale, scale);
}

#pragma mark - Image Rendering

- (UIImage *)renderDrawTextViewWithSize:(CGSize)size
{
    return [self drawTextImageWithSize:size
                       backgroundImage:nil];
}

- (UIImage *)drawTextOnImage:(UIImage *)image
{
    return [self drawTextImageWithSize:image.size backgroundImage:image];
}

- (UIImage *)drawTextImageWithSize:(CGSize)size backgroundImage:(UIImage *)backgroundImage
{
    CGFloat scale = size.width / CGRectGetWidth(self.bounds);
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, scale);
    
    [backgroundImage drawInRect:CGRectMake(0.f, 0.f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *drawnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [UIImage imageWithCGImage:drawnImage.CGImage
                               scale:1.f
                         orientation:drawnImage.imageOrientation];
}

@end
