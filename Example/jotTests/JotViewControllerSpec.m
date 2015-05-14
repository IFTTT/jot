//
//  JotViewControllerSpec.m
//  jot
//
//  Created by Laura Skelton on 5/7/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

// Uncomment the line below to record new snapshots.
//#define IS_RECORDING

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#define EXP_SHORTHAND
#include <Specta/Specta.h>
#include <Expecta/Expecta.h>
#include <Expecta+Snapshots/EXPMatchers+FBSnapshotTest.h>
#import <JotViewController.h>
#import <UIKit/UIKit.h>

@interface JotViewController ()

- (void)handleTapGesture:(UIGestureRecognizer *)recognizer;
- (void)handlePanGesture:(UIGestureRecognizer *)recognizer;
- (void)handlePinchOrRotateGesture:(UIGestureRecognizer *)recognizer;

@end

SpecBegin(JotViewController)

describe(@"JotViewController", ^{
    __block JotViewController *jotViewController;
    __block UIViewController *containerViewController;
    
    beforeEach(^{
        containerViewController = [UIViewController new];
        containerViewController.view.backgroundColor = [UIColor whiteColor];
        containerViewController.view.frame = CGRectMake(0.f, 0.f, 400.f, 600.f);

        jotViewController = [JotViewController new];
        jotViewController.view.frame = CGRectMake(0.f, 0.f, 400.f, 600.f);
        jotViewController.state = JotViewStateText;
        jotViewController.textString = @"Hello World";
        jotViewController.textColor = [UIColor blackColor];
        
        [containerViewController addChildViewController:jotViewController];
        [containerViewController.view addSubview:jotViewController.view];
        [jotViewController didMoveToParentViewController:containerViewController];
    });
    
    it(@"can be created", ^{
        expect(jotViewController).toNot.beNil();
    });
    
    it(@"displays the string", ^{
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextString");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextString");
    });
    
    it(@"clears the string", ^{
        [jotViewController clearText];
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"ClearText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"ClearText");
    });
    
    it(@"clears drawing", ^{
        jotViewController.state = JotViewStateDrawing;
        jotViewController.drawingConstantStrokeWidth = NO;
        jotViewController.drawingColor = [UIColor cyanColor];
        jotViewController.drawingStrokeWidth = 8.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingColor = [UIColor greenColor];
        jotViewController.drawingStrokeWidth = 15.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingConstantStrokeWidth = YES;
        jotViewController.drawingColor = [UIColor magentaColor];
        jotViewController.drawingStrokeWidth = 10.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController clearAll];
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"ClearDrawing");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"ClearDrawing");
    });
    
    it(@"clears all", ^{
        jotViewController.state = JotViewStateDrawing;
        jotViewController.drawingConstantStrokeWidth = NO;
        jotViewController.drawingColor = [UIColor cyanColor];
        jotViewController.drawingStrokeWidth = 8.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingColor = [UIColor greenColor];
        jotViewController.drawingStrokeWidth = 15.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingConstantStrokeWidth = YES;
        jotViewController.drawingColor = [UIColor magentaColor];
        jotViewController.drawingStrokeWidth = 10.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController clearAll];
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"ClearAll");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"ClearAll");
    });
    
    it(@"sets the font", ^{
        jotViewController.font = [UIFont boldSystemFontOfSize:50.f];
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"Font");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"Font");
    });
    
    it(@"sets the font size", ^{
        jotViewController.fontSize = 80.f;
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"FontSize");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"FontSize");
    });
    
    it(@"sets the text color", ^{
        jotViewController.textColor = [UIColor magentaColor];
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextColor");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextColor");
    });
    
    it(@"sets the text editing alignment to left if fitOriginalFontSizeToViewWidth is false", ^{
        [jotViewController.view layoutIfNeeded];
        jotViewController.textString = @"The quick brown fox jumped over the lazy dog.";
        jotViewController.fitOriginalFontSizeToViewWidth = NO;
        jotViewController.state = JotViewStateEditingText;
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextAlignmentLeftInEditMode");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextAlignmentLeftInEditMode");
    });
    
    it(@"sets the text alignment to left", ^{
        [jotViewController.view layoutIfNeeded];
        jotViewController.fitOriginalFontSizeToViewWidth = YES;
        jotViewController.textString = @"The quick brown fox jumped over the lazy dog.";
        jotViewController.fontSize = 60.f;
        jotViewController.textAlignment = NSTextAlignmentLeft;
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextAlignmentLeft");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextAlignmentLeft");
    });
    
    it(@"sets the text alignment to center", ^{
        [jotViewController.view layoutIfNeeded];
        jotViewController.fitOriginalFontSizeToViewWidth = YES;
        jotViewController.textString = @"The quick brown fox jumped over the lazy dog.";
        jotViewController.fontSize = 60.f;
        jotViewController.textAlignment = NSTextAlignmentCenter;
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextAlignmentCenter");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextAlignmentCenter");
    });
    
    it(@"sets the text alignment to right", ^{
        [jotViewController.view layoutIfNeeded];
        jotViewController.fitOriginalFontSizeToViewWidth = YES;
        jotViewController.textString = @"The quick brown fox jumped over the lazy dog.";
        jotViewController.fontSize = 60.f;
        jotViewController.textAlignment = NSTextAlignmentRight;
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextAlignmentRight");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextAlignmentRight");
    });
    
    it(@"sets the text insets", ^{
        [jotViewController.view layoutIfNeeded];
        jotViewController.fitOriginalFontSizeToViewWidth = YES;
        jotViewController.textString = @"The quick brown fox jumped over the lazy dog.";
        jotViewController.fontSize = 60.f;
        jotViewController.textAlignment = NSTextAlignmentLeft;
        jotViewController.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"TextInsets");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"TextInsets");
    });
    
    it(@"draws constant width lines", ^{
        jotViewController.state = JotViewStateDrawing;
        jotViewController.drawingConstantStrokeWidth = YES;
        jotViewController.drawingColor = [UIColor magentaColor];
        jotViewController.drawingStrokeWidth = 10.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[given([mockTouch locationInView:anything()])
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"ConstantWidthDrawing");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"ConstantWidthDrawing");
    });
    
    it(@"draws variable width lines", ^{
        jotViewController.state = JotViewStateDrawing;
        jotViewController.drawingConstantStrokeWidth = NO;
        jotViewController.drawingColor = [UIColor cyanColor];
        jotViewController.drawingStrokeWidth = 8.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[given([mockTouch locationInView:anything()])
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(containerViewController.view).notTo.recordSnapshotNamed(@"VariableWidthDrawing");
#endif
    });
    
    it(@"draws all line types", ^{
        jotViewController.state = JotViewStateDrawing;
        jotViewController.drawingConstantStrokeWidth = NO;
        jotViewController.drawingColor = [UIColor cyanColor];
        jotViewController.drawingStrokeWidth = 8.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingColor = [UIColor greenColor];
        jotViewController.drawingStrokeWidth = 15.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingConstantStrokeWidth = YES;
        jotViewController.drawingColor = [UIColor magentaColor];
        jotViewController.drawingStrokeWidth = 10.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(containerViewController.view).notTo.recordSnapshotNamed(@"DrawAllTypes");
#endif
    });
    
    it(@"handles pan gestures for large text", ^{
        [jotViewController.view layoutIfNeeded];
        jotViewController.fitOriginalFontSizeToViewWidth = YES;
        jotViewController.textString = @"The quick brown fox jumped over the lazy dog.";
        jotViewController.fontSize = 60.f;
        jotViewController.textAlignment = NSTextAlignmentLeft;
        jotViewController.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [jotViewController.view layoutIfNeeded];
        
        UIPanGestureRecognizer *mockPanRecognizer = mock([UIPanGestureRecognizer class]);
        
        [[[given([mockPanRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPanRecognizer translationInView:anything()])
         willReturn:[NSValue valueWithCGPoint:CGPointMake(100.f, 150.f)]];
        
        [jotViewController handlePanGesture:mockPanRecognizer];
        [jotViewController handlePanGesture:mockPanRecognizer];
        [jotViewController handlePanGesture:mockPanRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PanGestureLargeText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PanGestureLargeText");
    });
    
    it(@"handles pan gestures for single line text", ^{
        [jotViewController.view layoutIfNeeded];
        
        UIPanGestureRecognizer *mockPanRecognizer = mock([UIPanGestureRecognizer class]);
        
        [[[given([mockPanRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPanRecognizer translationInView:anything()])
         willReturn:[NSValue valueWithCGPoint:CGPointMake(100.f, 150.f)]];
        
        [jotViewController handlePanGesture:mockPanRecognizer];
        [jotViewController handlePanGesture:mockPanRecognizer];
        [jotViewController handlePanGesture:mockPanRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PanGestureSingleLineText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PanGestureSingleLineText");
    });
    
    it(@"handles rotate gestures for large text", ^{
        jotViewController.fitOriginalFontSizeToViewWidth = YES;
        jotViewController.textAlignment = NSTextAlignmentLeft;
        [jotViewController.view layoutIfNeeded];
        jotViewController.textString = @"The quick brown fox jumped over the lazy dog.";
        jotViewController.fontSize = 60.f;
        jotViewController.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [jotViewController.view layoutIfNeeded];
        
        UIRotationGestureRecognizer *mockRotationRecognizer = mock([UIRotationGestureRecognizer class]);
        
        [[[given([mockRotationRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockRotationRecognizer rotation])
         willReturn:@(0.75f)];
        
        [jotViewController handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockRotationRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"RotationGestureLargeText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"RotationGestureLargeText");
    });
    
    it(@"handles rotate gestures for single line text", ^{
        [jotViewController.view layoutIfNeeded];
        
        UIRotationGestureRecognizer *mockRotationRecognizer = mock([UIRotationGestureRecognizer class]);
        
        [[[given([mockRotationRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockRotationRecognizer rotation])
         willReturn:@(0.75f)];
        
        [jotViewController handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockRotationRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"RotationGestureSingleLineText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"RotationGestureSingleLineText");
    });
    
    it(@"handles pinch gestures for large text", ^{
        [jotViewController.view layoutIfNeeded];
        jotViewController.fitOriginalFontSizeToViewWidth = YES;
        jotViewController.textString = @"The quick brown fox jumped over the lazy dog.";
        jotViewController.fontSize = 60.f;
        jotViewController.textAlignment = NSTextAlignmentLeft;
        jotViewController.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [jotViewController.view layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(0.25f)];
        
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchGestureLargeText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchGestureLargeText");
    });
    
    it(@"handles pinch gestures for single line text", ^{
        [jotViewController.view layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(0.25f)];
        
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchGestureSingleLineText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchGestureSingleLineText");
    });
    
    it(@"handles zoom in pinch gestures for large text", ^{
        [jotViewController.view layoutIfNeeded];
        jotViewController.fitOriginalFontSizeToViewWidth = YES;
        jotViewController.textString = @"The quick brown fox jumped over the lazy dog.";
        jotViewController.fontSize = 60.f;
        jotViewController.textAlignment = NSTextAlignmentLeft;
        jotViewController.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [jotViewController.view layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(3.f)];
        
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchGestureZoomLargeText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchGestureZoomLargeText");
    });
    
    it(@"handles zoom in pinch gestures for single line text", ^{
        [jotViewController.view layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(3.f)];
        
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchGestureZoomSingleLineText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchGestureZoomSingleLineText");
    });
    
    it(@"handles pinch zoom and pan gestures for large text", ^{
        [jotViewController.view layoutIfNeeded];
        jotViewController.fitOriginalFontSizeToViewWidth = YES;
        jotViewController.textString = @"The quick brown fox jumped over the lazy dog.";
        jotViewController.fontSize = 60.f;
        jotViewController.textAlignment = NSTextAlignmentLeft;
        jotViewController.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [jotViewController.view layoutIfNeeded];
        
        UIPanGestureRecognizer *mockPanRecognizer = mock([UIPanGestureRecognizer class]);
        
        [[[given([mockPanRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPanRecognizer translationInView:anything()])
         willReturn:[NSValue valueWithCGPoint:CGPointMake(100.f, 150.f)]];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(0.15f)];
        
        UIRotationGestureRecognizer *mockRotationRecognizer = mock([UIRotationGestureRecognizer class]);
        
        [[[given([mockRotationRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockRotationRecognizer rotation])
         willReturn:@(0.75f)];
        
        [jotViewController handlePanGesture:mockPanRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        
        [jotViewController handlePanGesture:mockPanRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        
        [jotViewController handlePanGesture:mockPanRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchZoomPanGestureLargeText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchZoomPanGestureLargeText");
    });
    
    it(@"handles pinch zoom and pan gestures for single line text", ^{
        [jotViewController.view layoutIfNeeded];
        
        UIPanGestureRecognizer *mockPanRecognizer = mock([UIPanGestureRecognizer class]);
        
        [[[given([mockPanRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPanRecognizer translationInView:anything()])
         willReturn:[NSValue valueWithCGPoint:CGPointMake(100.f, 150.f)]];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(0.15f)];
        
        UIRotationGestureRecognizer *mockRotationRecognizer = mock([UIRotationGestureRecognizer class]);
        
        [[[given([mockRotationRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockRotationRecognizer rotation])
         willReturn:@(0.75f)];
        
        [jotViewController handlePanGesture:mockPanRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        
        [jotViewController handlePanGesture:mockPanRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        
        [jotViewController handlePanGesture:mockPanRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockRotationRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchZoomPanGestureSingleLineText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchZoomPanGestureSingleLineText");
    });
    
    it(@"handles pinch gestures for single line text", ^{
        [jotViewController.view layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(0.25f)];
        
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        [jotViewController handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"PinchGestureSingleLineText");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"PinchGestureSingleLineText");
    });
    
    it(@"renders all drawing types to an image at view size", ^{
        jotViewController.state = JotViewStateDrawing;
        jotViewController.drawingConstantStrokeWidth = NO;
        jotViewController.drawingColor = [UIColor cyanColor];
        jotViewController.drawingStrokeWidth = 8.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingColor = [UIColor greenColor];
        jotViewController.drawingStrokeWidth = 15.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingConstantStrokeWidth = YES;
        jotViewController.drawingColor = [UIColor magentaColor];
        jotViewController.drawingStrokeWidth = 10.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        UIImage *renderedImage = [jotViewController renderImage];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        imageView.backgroundColor = [UIColor lightGrayColor];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(imageView).notTo.recordSnapshotNamed(@"RenderDrawingAllTypes");
#endif
    });
    
    it(@"renders all drawing types to an image at a larger scale", ^{
        jotViewController.state = JotViewStateDrawing;
        jotViewController.drawingConstantStrokeWidth = NO;
        jotViewController.drawingColor = [UIColor cyanColor];
        jotViewController.drawingStrokeWidth = 8.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingColor = [UIColor greenColor];
        jotViewController.drawingStrokeWidth = 15.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingConstantStrokeWidth = YES;
        jotViewController.drawingColor = [UIColor magentaColor];
        jotViewController.drawingStrokeWidth = 10.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        UIImage *renderedImage = [jotViewController renderImageWithScale:2.f];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        imageView.backgroundColor = [UIColor lightGrayColor];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(imageView).notTo.recordSnapshotNamed(@"RenderDrawingAllTypesDoubleSize");
#endif
    });
    
    it(@"renders all drawing types on a color at double view size", ^{
        jotViewController.state = JotViewStateDrawing;
        jotViewController.drawingConstantStrokeWidth = NO;
        jotViewController.drawingColor = [UIColor cyanColor];
        jotViewController.drawingStrokeWidth = 8.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingColor = [UIColor greenColor];
        jotViewController.drawingStrokeWidth = 15.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingConstantStrokeWidth = YES;
        jotViewController.drawingColor = [UIColor magentaColor];
        jotViewController.drawingStrokeWidth = 10.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        UIImage *renderedImage = [jotViewController renderImageWithScale:2.f onColor:[UIColor yellowColor]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        imageView.backgroundColor = [UIColor lightGrayColor];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(imageView).notTo.recordSnapshotNamed(@"RenderDrawingAllTypesOnAColor");
#endif
    });
    
    it(@"renders all drawing types on a color at view size", ^{
        jotViewController.state = JotViewStateDrawing;
        jotViewController.drawingConstantStrokeWidth = NO;
        jotViewController.drawingColor = [UIColor cyanColor];
        jotViewController.drawingStrokeWidth = 8.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingColor = [UIColor greenColor];
        jotViewController.drawingStrokeWidth = 15.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingConstantStrokeWidth = YES;
        jotViewController.drawingColor = [UIColor magentaColor];
        jotViewController.drawingStrokeWidth = 10.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        UIImage *renderedImage = [jotViewController renderImageOnColor:[UIColor yellowColor]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        imageView.backgroundColor = [UIColor lightGrayColor];
        
#ifdef IS_RECORDING
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(imageView).notTo.recordSnapshotNamed(@"RenderDrawingAllTypesOnAColor");
#endif
    });
    
    it(@"draws all path types on top of a background image", ^{
        jotViewController.state = JotViewStateDrawing;
        jotViewController.drawingConstantStrokeWidth = NO;
        jotViewController.drawingColor = [UIColor cyanColor];
        jotViewController.drawingStrokeWidth = 8.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingColor = [UIColor greenColor];
        jotViewController.drawingStrokeWidth = 15.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingConstantStrokeWidth = YES;
        jotViewController.drawingColor = [UIColor magentaColor];
        jotViewController.drawingStrokeWidth = 10.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        UIImage *testImage = [UIImage imageNamed:@"JotTestImage.png"];
        UIImage *renderedImage = [jotViewController drawOnImage:testImage];
        
#ifdef IS_RECORDING
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        // NOTE: We can't force the touchesMoved methods to be called an exact time interval
        // apart, which means the velocity will differ slightly each time this is run, and
        // the snapshot test will fail since it is not pixel-perfect. This records
        // an image for visual confirmation but does not automatically check whether it is valid
        // against a previous image.
        expect(imageView).notTo.recordSnapshotNamed(@"DrawAllTypesOnBackgroundImage");
#else
        expect(renderedImage).toNot.beNil();
#endif
    });
    
    it(@"doesn't draw when in text mode", ^{
        jotViewController.state = JotViewStateText;
        jotViewController.drawingConstantStrokeWidth = NO;
        jotViewController.drawingColor = [UIColor cyanColor];
        jotViewController.drawingStrokeWidth = 8.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingColor = [UIColor greenColor];
        jotViewController.drawingStrokeWidth = 15.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingConstantStrokeWidth = YES;
        jotViewController.drawingColor = [UIColor magentaColor];
        jotViewController.drawingStrokeWidth = 10.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"DoesntDrawInTextMode");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"DoesntDrawInTextMode");
    });
    
    it(@"doesn't draw and hides text when in text edit mode", ^{
        jotViewController.state = JotViewStateEditingText;
        jotViewController.textAlignment = NSTextAlignmentLeft;
        jotViewController.drawingConstantStrokeWidth = NO;
        jotViewController.drawingColor = [UIColor cyanColor];
        jotViewController.drawingStrokeWidth = 8.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingColor = [UIColor greenColor];
        jotViewController.drawingStrokeWidth = 15.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingConstantStrokeWidth = YES;
        jotViewController.drawingColor = [UIColor magentaColor];
        jotViewController.drawingStrokeWidth = 10.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"DoesntDrawInTextEditMode");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"DoesntDrawInTextEditMode");
    });
    
    it(@"doesn't draw when in default mode", ^{
        jotViewController.state = JotViewStateDefault;
        jotViewController.drawingConstantStrokeWidth = NO;
        jotViewController.drawingColor = [UIColor cyanColor];
        jotViewController.drawingStrokeWidth = 8.f;
        [jotViewController.view layoutIfNeeded];
        
        UITouch *mockTouch = mock([UITouch class]);
        
        [[[[[[[[[[[[[given([mockTouch locationInView:anything()])
                     willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 0.f)]]
                    willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 100.f)]]
                   willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 200.f)]]
                  willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 240.f)]]
                 willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 290.f)]]
                
                willReturn:[NSValue valueWithCGPoint:CGPointMake(300.f, 500.f)]]
               willReturn:[NSValue valueWithCGPoint:CGPointMake(250.f, 400.f)]]
              willReturn:[NSValue valueWithCGPoint:CGPointMake(380.f, 480.f)]]
             
             willReturn:[NSValue valueWithCGPoint:CGPointMake(200.f, 500.f)]]
            willReturn:[NSValue valueWithCGPoint:CGPointMake(150.f, 400.f)]]
           willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 300.f)]]
          willReturn:[NSValue valueWithCGPoint:CGPointMake(260.f, 440.f)]]
         willReturn:[NSValue valueWithCGPoint:CGPointMake(180.f, 490.f)]];
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.02f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.05f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [NSThread sleepForTimeInterval:0.01f];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingColor = [UIColor greenColor];
        jotViewController.drawingStrokeWidth = 15.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
        jotViewController.drawingConstantStrokeWidth = YES;
        jotViewController.drawingColor = [UIColor magentaColor];
        jotViewController.drawingStrokeWidth = 10.f;
        
        [jotViewController.drawingContainer touchesBegan:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesMoved:[NSSet setWithObject:mockTouch] withEvent:nil];
        [jotViewController.drawingContainer touchesEnded:nil withEvent:nil];
        
#ifdef IS_RECORDING
        expect(containerViewController.view).to.recordSnapshotNamed(@"DoesntDrawInDefaultMode");
#endif
        expect(containerViewController.view).to.haveValidSnapshotNamed(@"DoesntDrawInDefaultMode");
    });
    
    afterEach(^{
        jotViewController = nil;
        containerViewController = nil;
    });
});

SpecEnd
