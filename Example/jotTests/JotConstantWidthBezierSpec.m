//
//  JotConstantWidthBezierSpec.m
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
#import <JotConstantWidthBezier.h>
#import <UIKit/UIKit.h>

SpecBegin(JotConstantWidthBezier)

describe(@"JotConstantWidthBezier", ^{
    
    it(@"can be created", ^{
        JotConstantWidthBezier *bezier = [JotConstantWidthBezier withStrokeWidth:10.f
                                                                           color:[UIColor cyanColor]];
        expect(bezier).toNot.beNil();
    });
    
    it(@"doesn't crash if context is nil", ^{
        
        JotConstantWidthBezier *bezier = [JotConstantWidthBezier withStrokeWidth:10.f
                                                                           color:[UIColor cyanColor]];
        
        [bezier moveToPoint:CGPointMake(0.f, 0.f)];
        [bezier addLineToPoint:CGPointMake(100.f, 150.f)];
        [bezier addLineToPoint:CGPointMake(100.f, 180.f)];
        
        UIGraphicsEndImageContext();
        
        [bezier jotDrawConstantWidthBezier];
        
        expect(UIGraphicsGetCurrentContext()).to.beNil;
    });
    
    it(@"draws a constant width bezier curve", ^{
        
        JotConstantWidthBezier *bezier = [JotConstantWidthBezier withStrokeWidth:10.f
                                                                           color:[UIColor cyanColor]];
        
        [bezier moveToPoint:CGPointMake(0.f, 0.f)];
        [bezier addLineToPoint:CGPointMake(100.f, 150.f)];
        [bezier addLineToPoint:CGPointMake(100.f, 180.f)];
        
        CGSize imageSize = CGSizeMake(200.f, 200.f);
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 2.f);
        [bezier jotDrawConstantWidthBezier];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"ConstantWidthBezierImage");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"ConstantWidthBezierImage");
    });
    
    it(@"sets independent color and stroke for different bezier curves", ^{
        
        JotConstantWidthBezier *bezier1 = [JotConstantWidthBezier withStrokeWidth:10.f
                                                                            color:[UIColor cyanColor]];
        
        [bezier1 moveToPoint:CGPointMake(0.f, 0.f)];
        [bezier1 addLineToPoint:CGPointMake(100.f, 150.f)];
        [bezier1 addLineToPoint:CGPointMake(100.f, 180.f)];
        
        JotConstantWidthBezier *bezier2 = [JotConstantWidthBezier withStrokeWidth:5.f
                                                                            color:[UIColor magentaColor]];
        
        [bezier2 moveToPoint:CGPointMake(200.f, 200.f)];
        [bezier2 addLineToPoint:CGPointMake(150.f, 100.f)];
        [bezier2 addLineToPoint:CGPointMake(80.f, 60.f)];
        
        CGSize imageSize = CGSizeMake(200.f, 200.f);
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 2.f);
        [bezier1 jotDrawConstantWidthBezier];
        [bezier2 jotDrawConstantWidthBezier];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"ConstantWidthSetsStrokeAndColorBezierImage");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"ConstantWidthSetsStrokeAndColorBezierImage");
    });
});

SpecEnd
