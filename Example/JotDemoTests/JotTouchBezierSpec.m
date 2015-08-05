//
//  JotTouchBezierSpec.m
//  jot
//
//  Created by Laura Skelton on 5/6/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

// Uncomment the line below to record new snapshots.
//#define IS_RECORDING

#define EXP_SHORTHAND
#include <Specta/Specta.h>
#include <Expecta/Expecta.h>
#include <Expecta+Snapshots/EXPMatchers+FBSnapshotTest.h>
#import <jot/JotTouchBezier.h>
#import <UIKit/UIKit.h>

SpecBegin(JotTouchBezier)

describe(@"JotTouchBezier", ^{
    __block JotTouchBezier *bezier;
    
    beforeAll(^{
        bezier = [JotTouchBezier new];
    });
    
    it(@"can be created", ^{
        expect(bezier).toNot.beNil();
    });
    
    it(@"doesn't crash if context is nil", ^{
        
        bezier.startPoint = CGPointMake(1.f, 10.f);
        bezier.endPoint = CGPointMake(99.f, 185.f);
        bezier.controlPoint1 = CGPointMake(17.f, 134.f);
        bezier.controlPoint2 = CGPointMake(83.f, 134.f);
        bezier.startWidth = 10.f;
        bezier.endWidth = 4.f;
        
        bezier.strokeColor = [UIColor cyanColor];
        UIGraphicsEndImageContext();
        
        [bezier jotDrawBezier];
        
        expect(UIGraphicsGetCurrentContext()).to.beNil;
    });
    
    it(@"draws a variable width wide to narrow cubic bezier curve", ^{
        
        bezier.startPoint = CGPointMake(1.f, 10.f);
        bezier.endPoint = CGPointMake(99.f, 185.f);
        bezier.controlPoint1 = CGPointMake(17.f, 134.f);
        bezier.controlPoint2 = CGPointMake(83.f, 134.f);
        bezier.startWidth = 10.f;
        bezier.endWidth = 4.f;
        
        bezier.strokeColor = [UIColor cyanColor];
        
        CGSize imageSize = CGSizeMake(100.f, 200.f);
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 2.f);
        [bezier jotDrawBezier];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"VariableWidthBezierImage");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"VariableWidthBezierImage");
    });
    
    it(@"draws a variable width narrow to wide cubic bezier curve", ^{
        
        bezier.startPoint = CGPointMake(0.f, 0.f);
        bezier.endPoint = CGPointMake(200.f, 100.f);
        bezier.controlPoint1 = CGPointMake(122.f, 14.f);
        bezier.controlPoint2 = CGPointMake(42.f, 77.f);
        
        bezier.startWidth = 2.f;
        bezier.endWidth = 7.f;
        
        bezier.strokeColor = [UIColor magentaColor];
        
        CGSize imageSize = CGSizeMake(200.f, 100.f);
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 2.f);
        [bezier jotDrawBezier];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"AnotherVariableWidthBezierImage");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"AnotherVariableWidthBezierImage");
    });
    
    it(@"draws a constant width cubic bezier curve if velocity is constant", ^{
        
        bezier.startPoint = CGPointMake(0.f, 0.f);
        bezier.endPoint = CGPointMake(200.f, 100.f);
        bezier.controlPoint1 = CGPointMake(122.f, 14.f);
        bezier.controlPoint2 = CGPointMake(42.f, 77.f);
        
        bezier.startWidth = 4.f;
        bezier.endWidth = 4.f;
        
        bezier.strokeColor = [UIColor blueColor];
                
        CGSize imageSize = CGSizeMake(200.f, 100.f);
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 2.f);
        [bezier jotDrawBezier];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"SameStartAndEndWidthBezierImage");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"SameStartAndEndWidthBezierImage");
    });
    
    it(@"draws a constant width cubic bezier curve if constantwidth is true", ^{
        
        bezier.startPoint = CGPointMake(0.f, 0.f);
        bezier.endPoint = CGPointMake(200.f, 100.f);
        bezier.controlPoint1 = CGPointMake(122.f, 14.f);
        bezier.controlPoint2 = CGPointMake(42.f, 77.f);
        bezier.constantWidth = YES;
        
        bezier.startWidth = 4.f;
        bezier.endWidth = 6.f;
        
        bezier.strokeColor = [UIColor blueColor];
        
        CGSize imageSize = CGSizeMake(200.f, 100.f);
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 2.f);
        [bezier jotDrawBezier];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"ConstantWidthBezierImage");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"ConstantWidthBezierImage");
    });
    
    it(@"draws some points", ^{
        
        CGSize imageSize = CGSizeMake(200.f, 100.f);
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 2.f);
        [[UIColor redColor] setFill];
        [JotTouchBezier jotDrawBezierPoint:CGPointMake(10.f, 20.f)
                                 withWidth:10.f];
        [[UIColor blueColor] setFill];
        [JotTouchBezier jotDrawBezierPoint:CGPointMake(20.f, 35.f)
                                 withWidth:5.f];
        [[UIColor greenColor] setFill];
        [JotTouchBezier jotDrawBezierPoint:CGPointMake(80.f, 45.f)
                                 withWidth:4.f];
        [[UIColor blackColor] setFill];
        [JotTouchBezier jotDrawBezierPoint:CGPointMake(160.f, 85.f)
                                 withWidth:20.f];
        [[UIColor whiteColor] setFill];
        [JotTouchBezier jotDrawBezierPoint:CGPointMake(180.f, 25.f)
                                 withWidth:12.f];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"BezierPoints");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"BezierPoints");
    });
    
    afterAll(^{
        bezier = nil;
    });
});

SpecEnd
