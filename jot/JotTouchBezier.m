//
//  JotTouchBezier.m
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//
//

#import "JotTouchBezier.h"

NSUInteger const kJotDrawStepsPerBezier = 300;
CGFloat const kJotBezierShadow = 0.65f;

static inline CGFloat pointLength(const CGPoint point1, const CGPoint point2){
    return sqrt(pow(point1.x - point2.x, 2) + pow(point1.y - point2.y, 2));
}

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
        
        CGFloat minWidth = self.startWidth;
        CGFloat widthDelta = self.endWidth - self.startWidth;
        
        CGFloat length = pointLength(self.startPoint, self.controlPoint1)
                        + pointLength(self.controlPoint1, self.controlPoint2)
                        + pointLength(self.controlPoint2, self.endPoint);
        
        CGFloat drawSteps = MAX(MIN(length,kJotDrawStepsPerBezier),10);

        for (NSUInteger i = 0; i < drawSteps; i++) {
            
            CGFloat t = ((CGFloat)i) / (CGFloat)drawSteps;
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
            minWidth = MIN(pointWidth, minWidth);
            
            [self.class jotDrawBezierPoint:CGPointMake(x, y) withWidth:pointWidth];
        }
        
        // Draw a min width bezier, in case of drawSteps is not enough
        CGFloat span = 0.0f;
        CGPoint startPoint = CGPointMake(self.startPoint.x, self.startPoint.y + span);
        CGPoint controlPoint1 = CGPointMake(self.controlPoint1.x, self.controlPoint1.y + span);
        CGPoint controlPoint2 = CGPointMake(self.controlPoint2.x, self.controlPoint2.y + span);
        CGPoint endPoint = CGPointMake(self.endPoint.x, self.endPoint.y + span);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, minWidth);
        CGContextSetAllowsAntialiasing(context, true);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        CGContextAddCurveToPoint(context, controlPoint1.x, controlPoint1.y,
                                 controlPoint2.x, controlPoint2.y, endPoint.x, endPoint.y);
        CGContextStrokePath(context);
    }
}

+ (void)jotDrawBezierPoint:(CGPoint)point withWidth:(CGFloat)width
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        return;
    }
    
    // Set shadow makes bezier path more smoothly
    CGContextSetShadow(context, CGSizeMake(0, 0), kJotBezierShadow);
    CGContextFillEllipseInRect(context, CGRectInset(CGRectMake(point.x, point.y, 0.f, 0.f), -width / 2.f, -width / 2.f));
}

@end
