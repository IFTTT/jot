//
//  JotTouchBezier.m
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import "JotTouchBezier.h"

NSUInteger const kJotDrawStepsPerBezier = 300;

@implementation JotTouchBezier

+ (instancetype)withColor:(UIColor *)color
{
    JotTouchBezier *touchBezier = [JotTouchBezier new];
    
    touchBezier.strokeColor = color;
    
    return touchBezier;
}

- (void)jotDrawBezier
{
    if (self.constantWidth) {
        UIBezierPath *bezierPath = [UIBezierPath new];
        [bezierPath moveToPoint:self.startPoint];
        [bezierPath addCurveToPoint:self.endPoint controlPoint1:self.controlPoint1 controlPoint2:self.controlPoint2];
        bezierPath.lineWidth = self.startWidth;
        bezierPath.lineCapStyle = kCGLineCapRound;
        [self.strokeColor setStroke];
        [bezierPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.f];
    } else {
        [self.strokeColor setFill];
        
        CGFloat widthDelta = self.endWidth - self.startWidth;
        
        for (NSUInteger i = 0; i < kJotDrawStepsPerBezier; i++) {
            
            CGFloat t = ((CGFloat)i) / (CGFloat)kJotDrawStepsPerBezier;
            CGFloat tt = t * t;
            CGFloat ttt = tt * t;
            CGFloat u = 1.f - t;
            CGFloat uu = u * u;
            CGFloat uuu = uu * u;
            
            CGFloat x = uuu * self.startPoint.x;
            x += 3 * uu * t * self.controlPoint1.x;
            x += 3 * u * tt * self.controlPoint2.x;
            x += ttt * self.endPoint.x;
            
            CGFloat y = uuu * self.startPoint.y;
            y += 3 * uu * t * self.controlPoint1.y;
            y += 3 * u * tt * self.controlPoint2.y;
            y += ttt * self.endPoint.y;
            
            CGFloat pointWidth = self.startWidth + (ttt * widthDelta);
            [self.class jotDrawBezierPoint:CGPointMake(x, y) withWidth:pointWidth];
        }
    }
}

+ (void)jotDrawBezierPoint:(CGPoint)point withWidth:(CGFloat)width
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        return;
    }
    
    CGContextFillEllipseInRect(context, CGRectInset(CGRectMake(point.x, point.y, 0.f, 0.f), -width / 2.f, -width / 2.f));
}

@end
