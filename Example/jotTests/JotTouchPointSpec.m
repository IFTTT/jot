//
//  JotTouchPointSpec.m
//  jot
//
//  Created by Laura Skelton on 5/6/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

#define EXP_SHORTHAND
#include <Specta/Specta.h>
#include <Expecta/Expecta.h>
#import <JotTouchPoint.h>
#import <UIKit/UIKit.h>

SpecBegin(JotTouchPoint)

describe(@"JotTouchPoint", ^{
    __block JotTouchPoint *touchPoint1;
    __block JotTouchPoint *touchPoint2;
    
    beforeAll(^{
        touchPoint1 = [JotTouchPoint withPoint:CGPointMake(10.f, 20.f)];
        touchPoint2 = [JotTouchPoint withPoint:CGPointMake(10.f, 30.f)];
        touchPoint1.timestamp = [NSDate dateWithTimeIntervalSinceReferenceDate:10.f];
        touchPoint2.timestamp = [NSDate dateWithTimeIntervalSinceReferenceDate:20.f];
    });
    
    it(@"can be created", ^{
        expect(touchPoint1).toNot.beNil();
        expect(touchPoint2).toNot.beNil();
    });
    
    it(@"has the correct timestamp", ^{
        expect(touchPoint1.timestamp).to.equal([NSDate dateWithTimeIntervalSinceReferenceDate:10.f]);
        expect(touchPoint2.timestamp).to.equal([NSDate dateWithTimeIntervalSinceReferenceDate:20.f]);
    });
    
    it(@"has the correct CGPoint value", ^{
        expect(CGPointEqualToPoint(touchPoint1.CGPointValue, CGPointMake(10.f, 20.f))).to.beTruthy();
        expect(CGPointEqualToPoint(touchPoint2.CGPointValue, CGPointMake(10.f, 30.f))).to.beTruthy();
    });
    
    it(@"calculates the correct velocity", ^{
        CGFloat velocity = [touchPoint2 velocityFromPoint:touchPoint1];
        expect(velocity).to.equal(1.f);
    });
    
    it(@"calculates the correct velocity in either direction", ^{
        CGFloat velocity = [touchPoint1 velocityFromPoint:touchPoint2];
        expect(velocity).to.equal(1.f);
    });
    
    afterAll(^{
        touchPoint1 = nil;
        touchPoint2 = nil;
    });
});

SpecEnd
