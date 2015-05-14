//
//  JotDrawViewSpec.m
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
#import <JotDrawView.h>
#import <UIKit/UIKit.h>

SpecBegin(JotDrawView)

describe(@"JotDrawView", ^{
    __block JotDrawView *drawView;
    
    beforeEach(^{
        drawView = [JotDrawView new];
        drawView.frame = CGRectMake(0.f, 0.f, 200.f, 200.f);
    });
    
    it(@"can be created", ^{
        expect(drawView).toNot.beNil();
    });
    
    it(@"draws constant-width bezier curves", ^{
        drawView.constantStrokeWidth = YES;
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [drawView drawTouchEnded];
#ifdef IS_RECORDING
        expect(drawView).to.recordSnapshotNamed(@"ConstantWidthBezierDrawing");
#endif
        expect(drawView).to.haveValidSnapshotNamed(@"ConstantWidthBezierDrawing");
    });
    
    it(@"draws variable-width bezier curves", ^{
        drawView.constantStrokeWidth = NO;
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [NSThread sleepForTimeInterval:0.2f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [NSThread sleepForTimeInterval:0.5f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [NSThread sleepForTimeInterval:0.001f];
        [drawView drawTouchMovedToPoint:CGPointMake(90.f, 170.f)];
        [NSThread sleepForTimeInterval:0.002f];
        [drawView drawTouchMovedToPoint:CGPointMake(40.f, 20.f)];
        [NSThread sleepForTimeInterval:0.2f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [NSThread sleepForTimeInterval:0.5f];
        [drawView drawTouchMovedToPoint:CGPointMake(170.f, 120.f)];
        [NSThread sleepForTimeInterval:0.001f];
        [drawView drawTouchMovedToPoint:CGPointMake(150.f, 100.f)];
        [NSThread sleepForTimeInterval:0.002f];
        [drawView drawTouchMovedToPoint:CGPointMake(120.f, 70.f)];
        [drawView drawTouchEnded];
#ifdef IS_RECORDING
        // NOTE: We can't force the drawTouchMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(drawView).notTo.recordSnapshotNamed(@"VariableWidthBezierDrawing");
#endif
    });
    
    it(@"draws points on single touch in variable-width draw mode", ^{
        drawView.constantStrokeWidth = NO;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 100.f)];
        [drawView drawTouchEnded];
        [drawView drawTouchBeganAtPoint:CGPointMake(150.f, 100.f)];
        [drawView drawTouchEnded];
        [drawView drawTouchBeganAtPoint:CGPointMake(50.f, 50.f)];
        [drawView drawTouchEnded];
#ifdef IS_RECORDING
        expect(drawView).to.recordSnapshotNamed(@"SinglePointBezierDrawing");
#endif
        expect(drawView).to.haveValidSnapshotNamed(@"SinglePointBezierDrawing");
    });
    
    it(@"draws all drawing types in the same draw view", ^{
        drawView.constantStrokeWidth = NO;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 100.f)];
        [drawView drawTouchEnded];
        [drawView drawTouchBeganAtPoint:CGPointMake(150.f, 100.f)];
        [drawView drawTouchEnded];
        [drawView drawTouchBeganAtPoint:CGPointMake(50.f, 50.f)];
        [drawView drawTouchEnded];
        
        [drawView drawTouchBeganAtPoint:CGPointMake(200.f, 200.f)];
        [NSThread sleepForTimeInterval:0.2f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [NSThread sleepForTimeInterval:0.5f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [NSThread sleepForTimeInterval:0.001f];
        [drawView drawTouchMovedToPoint:CGPointMake(90.f, 170.f)];
        [NSThread sleepForTimeInterval:0.002f];
        [drawView drawTouchMovedToPoint:CGPointMake(40.f, 20.f)];
        [NSThread sleepForTimeInterval:0.002f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [NSThread sleepForTimeInterval:0.002f];
        [drawView drawTouchMovedToPoint:CGPointMake(170.f, 120.f)];
        [NSThread sleepForTimeInterval:0.001f];
        [drawView drawTouchMovedToPoint:CGPointMake(150.f, 100.f)];
        [NSThread sleepForTimeInterval:0.002f];
        [drawView drawTouchMovedToPoint:CGPointMake(120.f, 70.f)];
        [drawView drawTouchEnded];
        
        drawView.constantStrokeWidth = YES;
        [drawView drawTouchBeganAtPoint:CGPointMake(60.f, 0.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(10.f, 150.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(20.f, 180.f)];
        [drawView drawTouchEnded];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the drawTouchMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(drawView).notTo.recordSnapshotNamed(@"AllTypesDrawing");
#endif
    });
    
    it(@"clears drawing from constant width bezier curves", ^{
        drawView.constantStrokeWidth = YES;
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [drawView drawTouchEnded];
        [drawView clearDrawing];
#ifdef IS_RECORDING
        expect(drawView).to.recordSnapshotNamed(@"ClearDrawingConstantWidth");
#endif
        expect(drawView).to.haveValidSnapshotNamed(@"ClearDrawingConstantWidth");
    });
    
    it(@"clears drawing from variable width bezier curves", ^{
        drawView.constantStrokeWidth = NO;
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [NSThread sleepForTimeInterval:0.05f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [NSThread sleepForTimeInterval:0.01f];
        [drawView drawTouchMovedToPoint:CGPointMake(90.f, 170.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(40.f, 20.f)];
        [drawView drawTouchEnded];
        [drawView clearDrawing];
#ifdef IS_RECORDING
        expect(drawView).to.recordSnapshotNamed(@"ClearDrawingVariableWidth");
#endif
        expect(drawView).to.haveValidSnapshotNamed(@"ClearDrawingVariableWidth");
    });
    
    it(@"clears drawing from single touch in variable-width draw mode", ^{
        drawView.constantStrokeWidth = NO;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 100.f)];
        [drawView drawTouchEnded];
        [drawView drawTouchBeganAtPoint:CGPointMake(150.f, 100.f)];
        [drawView drawTouchEnded];
        [drawView drawTouchBeganAtPoint:CGPointMake(50.f, 50.f)];
        [drawView drawTouchEnded];
        [drawView clearDrawing];
#ifdef IS_RECORDING
        expect(drawView).to.recordSnapshotNamed(@"ClearDrawingSinglePoint");
#endif
        expect(drawView).to.haveValidSnapshotNamed(@"ClearDrawingSinglePoint");
    });
    
    it(@"clears drawing from all drawing types", ^{
        drawView.constantStrokeWidth = NO;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 100.f)];
        [drawView drawTouchEnded];
        [drawView drawTouchBeganAtPoint:CGPointMake(150.f, 100.f)];
        [drawView drawTouchEnded];
        [drawView drawTouchBeganAtPoint:CGPointMake(50.f, 50.f)];
        [drawView drawTouchEnded];
        
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [NSThread sleepForTimeInterval:0.05f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [NSThread sleepForTimeInterval:0.01f];
        [drawView drawTouchMovedToPoint:CGPointMake(90.f, 170.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(40.f, 20.f)];
        [drawView drawTouchEnded];
        
        drawView.constantStrokeWidth = YES;
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [drawView drawTouchEnded];
        
        [drawView clearDrawing];
#ifdef IS_RECORDING
        expect(drawView).to.recordSnapshotNamed(@"ClearDrawingAllTypes");
#endif
        expect(drawView).to.haveValidSnapshotNamed(@"ClearDrawingAllTypes");
    });
    
    it(@"changes color of constant-width bezier curves", ^{
        drawView.constantStrokeWidth = YES;
        drawView.strokeColor = [UIColor magentaColor];
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [drawView drawTouchEnded];
        
        drawView.strokeColor = [UIColor cyanColor];
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 50.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(10.f, 40.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 0.f)];
        [drawView drawTouchEnded];
#ifdef IS_RECORDING
        expect(drawView).to.recordSnapshotNamed(@"ConstantWidthColorChangeBezierDrawing");
#endif
        expect(drawView).to.haveValidSnapshotNamed(@"ConstantWidthColorChangeBezierDrawing");
    });
    
    it(@"changes color of variable-width bezier curves", ^{
        drawView.constantStrokeWidth = NO;
        drawView.strokeColor = [UIColor magentaColor];
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [NSThread sleepForTimeInterval:0.05f];
        [drawView drawTouchMovedToPoint:CGPointMake(140.f, 180.f)];
        [NSThread sleepForTimeInterval:0.01f];
        [drawView drawTouchMovedToPoint:CGPointMake(130.f, 170.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(40.f, 20.f)];
        [drawView drawTouchEnded];
        
        drawView.strokeColor = [UIColor cyanColor];
        [drawView drawTouchBeganAtPoint:CGPointMake(200.f, 0.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(150.f, 100.f)];
        [NSThread sleepForTimeInterval:0.05f];
        [drawView drawTouchMovedToPoint:CGPointMake(180.f, 100.f)];
        [NSThread sleepForTimeInterval:0.01f];
        [drawView drawTouchMovedToPoint:CGPointMake(200.f, 120.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(20.f, 40.f)];
        [drawView drawTouchEnded];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the drawTouchMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(drawView).notTo.recordSnapshotNamed(@"VariableWidthColorChangeBezierDrawing");
#endif
    });
    
    it(@"changes color of single touch points in variable-width draw mode", ^{
        drawView.constantStrokeWidth = NO;
        drawView.strokeColor = [UIColor magentaColor];
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 100.f)];
        [drawView drawTouchEnded];
        drawView.strokeColor = [UIColor cyanColor];
        [drawView drawTouchBeganAtPoint:CGPointMake(150.f, 100.f)];
        [drawView drawTouchEnded];
        drawView.strokeColor = [UIColor yellowColor];
        [drawView drawTouchBeganAtPoint:CGPointMake(50.f, 50.f)];
        [drawView drawTouchEnded];
#ifdef IS_RECORDING
        expect(drawView).to.recordSnapshotNamed(@"SinglePointColorChangeBezierDrawing");
#endif
        expect(drawView).to.haveValidSnapshotNamed(@"SinglePointColorChangeBezierDrawing");
    });
    
    it(@"changes width of constant-width bezier curves", ^{
        drawView.constantStrokeWidth = YES;
        drawView.strokeWidth = 10.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [drawView drawTouchEnded];
        
        drawView.strokeWidth = 4.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 50.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(10.f, 40.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 0.f)];
        [drawView drawTouchEnded];
#ifdef IS_RECORDING
        expect(drawView).to.recordSnapshotNamed(@"ConstantWidthWidthChangeBezierDrawing");
#endif
        expect(drawView).to.haveValidSnapshotNamed(@"ConstantWidthWidthChangeBezierDrawing");
    });
    
    it(@"changes width of variable-width bezier curves", ^{
        drawView.constantStrokeWidth = NO;
        drawView.strokeWidth = 10.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [NSThread sleepForTimeInterval:0.05f];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [NSThread sleepForTimeInterval:0.01f];
        [drawView drawTouchMovedToPoint:CGPointMake(90.f, 170.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(40.f, 20.f)];
        [drawView drawTouchEnded];
        
        drawView.strokeWidth = 4.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(200.f, 0.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(150.f, 100.f)];
        [NSThread sleepForTimeInterval:0.05f];
        [drawView drawTouchMovedToPoint:CGPointMake(180.f, 100.f)];
        [NSThread sleepForTimeInterval:0.01f];
        [drawView drawTouchMovedToPoint:CGPointMake(170.f, 90.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(20.f, 40.f)];
        [drawView drawTouchEnded];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the drawTouchMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(drawView).notTo.recordSnapshotNamed(@"VariableWidthWidthChangeBezierDrawing");
#endif
    });
    
    it(@"changes width of single touch points in variable-width draw mode", ^{
        drawView.constantStrokeWidth = NO;
        drawView.strokeWidth = 10.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 100.f)];
        [drawView drawTouchEnded];
        drawView.strokeWidth = 4.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(150.f, 100.f)];
        [drawView drawTouchEnded];
        drawView.strokeWidth = 2.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(50.f, 50.f)];
        [drawView drawTouchEnded];
#ifdef IS_RECORDING
        expect(drawView).to.recordSnapshotNamed(@"SinglePointWidthChangeBezierDrawing");
#endif
        expect(drawView).to.haveValidSnapshotNamed(@"SinglePointWidthChangeBezierDrawing");
    });
    
    it(@"renders constant width path and single points to an image", ^{
        drawView.constantStrokeWidth = YES;
        drawView.strokeColor = [UIColor magentaColor];
        drawView.strokeWidth = 10.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [drawView drawTouchEnded];
        
        drawView.strokeColor = [UIColor cyanColor];
        drawView.strokeWidth = 4.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 50.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(10.f, 40.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 0.f)];
        [drawView drawTouchEnded];
        
        drawView.constantStrokeWidth = NO;
        drawView.strokeColor = [UIColor magentaColor];
        drawView.strokeWidth = 4.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 100.f)];
        [drawView drawTouchEnded];
        drawView.strokeColor = [UIColor cyanColor];
        drawView.strokeWidth = 12.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(150.f, 100.f)];
        [drawView drawTouchEnded];
        drawView.strokeColor = [UIColor yellowColor];
        drawView.strokeWidth = 20.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(50.f, 50.f)];
        [drawView drawTouchEnded];
        
        UIImage *renderedImage = [drawView renderDrawingWithSize:CGSizeMake(600.f, 600.f)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        imageView.backgroundColor = [UIColor lightGrayColor];
        
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"RenderDrawingConstantAndPointTypes");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"RenderDrawingConstantAndPointTypes");
    });
    
    it(@"renders all drawing types to an image", ^{
        drawView.constantStrokeWidth = YES;
        drawView.strokeColor = [UIColor magentaColor];
        drawView.strokeWidth = 10.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [drawView drawTouchEnded];
        
        drawView.strokeColor = [UIColor cyanColor];
        drawView.strokeWidth = 4.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 50.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(10.f, 40.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 0.f)];
        [drawView drawTouchEnded];
        
        drawView.constantStrokeWidth = NO;
        drawView.strokeColor = [UIColor magentaColor];
        drawView.strokeWidth = 4.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 100.f)];
        [drawView drawTouchEnded];
        drawView.strokeColor = [UIColor cyanColor];
        drawView.strokeWidth = 12.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(150.f, 100.f)];
        [drawView drawTouchEnded];
        drawView.strokeColor = [UIColor yellowColor];
        drawView.strokeWidth = 20.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(50.f, 50.f)];
        [drawView drawTouchEnded];
        
        drawView.strokeColor = [UIColor greenColor];
        drawView.strokeWidth = 8.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(200.f, 0.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(150.f, 100.f)];
        [NSThread sleepForTimeInterval:0.05f];
        [drawView drawTouchMovedToPoint:CGPointMake(180.f, 100.f)];
        [NSThread sleepForTimeInterval:0.01f];
        [drawView drawTouchMovedToPoint:CGPointMake(200.f, 120.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(20.f, 40.f)];
        [drawView drawTouchEnded];
        
        UIImage *renderedImage = [drawView renderDrawingWithSize:CGSizeMake(600.f, 600.f)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        imageView.backgroundColor = [UIColor lightGrayColor];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the drawTouchMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(imageView).notTo.recordSnapshotNamed(@"RenderDrawingAllTypes");
#endif
    });
    
    it(@"draws constant width path and single points on top of a background image", ^{
        drawView.constantStrokeWidth = YES;
        drawView.strokeColor = [UIColor magentaColor];
        drawView.strokeWidth = 10.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [drawView drawTouchEnded];
        
        drawView.strokeColor = [UIColor cyanColor];
        drawView.strokeWidth = 4.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 50.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(10.f, 40.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 0.f)];
        [drawView drawTouchEnded];
        
        drawView.constantStrokeWidth = NO;
        drawView.strokeColor = [UIColor magentaColor];
        drawView.strokeWidth = 4.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 100.f)];
        [drawView drawTouchEnded];
        drawView.strokeColor = [UIColor cyanColor];
        drawView.strokeWidth = 12.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(150.f, 100.f)];
        [drawView drawTouchEnded];
        drawView.strokeColor = [UIColor yellowColor];
        drawView.strokeWidth = 20.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(50.f, 50.f)];
        [drawView drawTouchEnded];
        
        UIImage *testImage = [UIImage imageNamed:@"JotTestImage.png"];
        UIImage *renderedImage = [drawView drawOnImage:testImage];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"DrawConstantAndPointTypesOnBackgroundImage");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"DrawConstantAndPointTypesOnBackgroundImage");
    });
    
    it(@"draws all path types on top of a background image", ^{
        drawView.constantStrokeWidth = YES;
        drawView.strokeColor = [UIColor magentaColor];
        drawView.strokeWidth = 10.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(0.f, 0.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 150.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 180.f)];
        [drawView drawTouchEnded];
        
        drawView.strokeColor = [UIColor cyanColor];
        drawView.strokeWidth = 4.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 50.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(10.f, 40.f)];
        [drawView drawTouchMovedToPoint:CGPointMake(100.f, 0.f)];
        [drawView drawTouchEnded];
        
        drawView.constantStrokeWidth = NO;
        drawView.strokeColor = [UIColor magentaColor];
        drawView.strokeWidth = 4.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(100.f, 100.f)];
        [drawView drawTouchEnded];
        drawView.strokeColor = [UIColor cyanColor];
        drawView.strokeWidth = 12.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(150.f, 100.f)];
        [drawView drawTouchEnded];
        drawView.strokeColor = [UIColor yellowColor];
        drawView.strokeWidth = 20.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(50.f, 50.f)];
        [drawView drawTouchEnded];
        
        drawView.strokeColor = [UIColor greenColor];
        drawView.strokeWidth = 8.f;
        [drawView drawTouchBeganAtPoint:CGPointMake(200.f, 0.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(150.f, 100.f)];
        [NSThread sleepForTimeInterval:0.05f];
        [drawView drawTouchMovedToPoint:CGPointMake(180.f, 100.f)];
        [NSThread sleepForTimeInterval:0.01f];
        [drawView drawTouchMovedToPoint:CGPointMake(200.f, 120.f)];
        [NSThread sleepForTimeInterval:0.02f];
        [drawView drawTouchMovedToPoint:CGPointMake(20.f, 40.f)];
        [drawView drawTouchEnded];
        
        UIImage *testImage = [UIImage imageNamed:@"JotTestImage.png"];
        UIImage *renderedImage = [drawView drawOnImage:testImage];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the drawTouchMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(imageView).notTo.recordSnapshotNamed(@"DrawAllTypesOnBackgroundImage");
#endif
    });
    
    afterEach(^{
        drawView = nil;
    });
});

SpecEnd
