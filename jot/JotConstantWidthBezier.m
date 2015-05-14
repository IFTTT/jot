//
//  JotConstantWidthBezier.m
//  jot
//
//  Created by Laura Skelton on 5/6/15.
//
//

#import "JotConstantWidthBezier.h"

@interface JotConstantWidthBezier ()

@property (nonatomic, strong, readwrite) UIColor *strokeColor;

@end

@implementation JotConstantWidthBezier

+ (instancetype)withStrokeWidth:(CGFloat)strokeWidth color:(UIColor *)color
{
    JotConstantWidthBezier *constantWidthBezier = [JotConstantWidthBezier new];
    
    constantWidthBezier.strokeColor = color;
    
    UIBezierPath *bezierPath = [UIBezierPath new];
    [bezierPath setLineCapStyle:kCGLineCapRound];
    [bezierPath setMiterLimit:0.f];
    [bezierPath setLineWidth:strokeWidth];
    
    constantWidthBezier.bezierPath = bezierPath;
    
    return constantWidthBezier;
}

- (void)jotDrawConstantWidthBezier
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        return;
    }
    
    [self.strokeColor setStroke];
    [self.bezierPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.f];
}

- (void)moveToPoint:(CGPoint)point
{
    [self.bezierPath moveToPoint:point];
}

- (void)addLineToPoint:(CGPoint)point
{
    [self.bezierPath addLineToPoint:point];
}

@end
