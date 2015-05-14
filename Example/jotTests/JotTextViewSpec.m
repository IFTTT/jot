//
//  JotTextViewSpec.m
//  jot
//
//  Created by Laura Skelton on 5/6/15.
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
#import <JotTextView.h>
#import <UIKit/UIKit.h>

SpecBegin(JotTextView)

describe(@"JotTextView", ^{
    __block JotTextView *textView;
    
    beforeEach(^{
        textView = [JotTextView new];
        textView.frame = CGRectMake(0.f, 0.f, 400.f, 600.f);
        textView.textString = @"Hello World";
        textView.textColor = [UIColor blackColor];
    });
    
    it(@"can be created", ^{
        expect(textView).toNot.beNil();
    });
    
    it(@"displays the string", ^{
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"TextString");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"TextString");
    });
    
    it(@"clears the string", ^{
        textView.textString = @"";
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"Clear");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"Clear");
    });
    
    it(@"sets the font", ^{
        textView.font = [UIFont boldSystemFontOfSize:50.f];
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"Font");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"Font");
    });
    
    it(@"sets the font size", ^{
        textView.fontSize = 80.f;
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"FontSize");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"FontSize");
    });
    
    it(@"sets the text color", ^{
        textView.textColor = [UIColor magentaColor];
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"TextColor");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"TextColor");
    });
    
    it(@"sets the text alignment to left", ^{
        textView.fitOriginalFontSizeToViewWidth = YES;
        textView.textString = @"The quick brown fox jumped over the lazy dog.";
        textView.fontSize = 60.f;
        textView.textAlignment = NSTextAlignmentLeft;
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"TextAlignmentLeft");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"TextAlignmentLeft");
    });
    
    it(@"sets the text alignment to center", ^{
        textView.fitOriginalFontSizeToViewWidth = YES;
        textView.textString = @"The quick brown fox jumped over the lazy dog.";
        textView.fontSize = 60.f;
        textView.textAlignment = NSTextAlignmentCenter;
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"TextAlignmentCenter");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"TextAlignmentCenter");
    });
    
    it(@"sets the text alignment to right", ^{
        textView.fitOriginalFontSizeToViewWidth = YES;
        textView.textString = @"The quick brown fox jumped over the lazy dog.";
        textView.fontSize = 60.f;
        textView.textAlignment = NSTextAlignmentRight;
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"TextAlignmentRight");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"TextAlignmentRight");
    });
    
    it(@"sets the text insets", ^{
        textView.fitOriginalFontSizeToViewWidth = YES;
        textView.textString = @"The quick brown fox jumped over the lazy dog.";
        textView.fontSize = 60.f;
        textView.textAlignment = NSTextAlignmentLeft;
        textView.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"TextInsets");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"TextInsets");
    });
    
    it(@"handles pan gestures for large text", ^{
        textView.fitOriginalFontSizeToViewWidth = YES;
        textView.textString = @"The quick brown fox jumped over the lazy dog.";
        textView.fontSize = 60.f;
        textView.textAlignment = NSTextAlignmentLeft;
        textView.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [textView layoutIfNeeded];
        
        UIPanGestureRecognizer *mockPanRecognizer = mock([UIPanGestureRecognizer class]);
        
        [[[given([mockPanRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPanRecognizer translationInView:anything()])
         willReturn:[NSValue valueWithCGPoint:CGPointMake(100.f, 150.f)]];
        
        [textView handlePanGesture:mockPanRecognizer];
        [textView handlePanGesture:mockPanRecognizer];
        [textView handlePanGesture:mockPanRecognizer];
        
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"PanGestureLargeText");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"PanGestureLargeText");
    });
    
    it(@"handles pan gestures for single line text", ^{
        [textView layoutIfNeeded];
        
        UIPanGestureRecognizer *mockPanRecognizer = mock([UIPanGestureRecognizer class]);
        
        [[[given([mockPanRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPanRecognizer translationInView:anything()])
         willReturn:[NSValue valueWithCGPoint:CGPointMake(100.f, 150.f)]];
        
        [textView handlePanGesture:mockPanRecognizer];
        [textView handlePanGesture:mockPanRecognizer];
        [textView handlePanGesture:mockPanRecognizer];
        
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"PanGestureSingleLineText");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"PanGestureSingleLineText");
    });
    
    it(@"doesn't crash if gesture recognizer is wrong class", ^{
        [textView layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [textView handlePanGesture:mockPinchRecognizer];
        [textView handlePanGesture:mockPinchRecognizer];
        [textView handlePanGesture:mockPinchRecognizer];
    });
    
    it(@"handles rotate gestures for large text", ^{
        textView.fitOriginalFontSizeToViewWidth = YES;
        textView.textString = @"The quick brown fox jumped over the lazy dog.";
        textView.fontSize = 60.f;
        textView.textAlignment = NSTextAlignmentLeft;
        textView.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [textView layoutIfNeeded];
        
        UIRotationGestureRecognizer *mockRotationRecognizer = mock([UIRotationGestureRecognizer class]);
        
        [[[given([mockRotationRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockRotationRecognizer rotation])
         willReturn:@(0.75f)];
        
        [textView handlePinchOrRotateGesture:mockRotationRecognizer];
        [textView handlePinchOrRotateGesture:mockRotationRecognizer];
        [textView handlePinchOrRotateGesture:mockRotationRecognizer];
        
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"RotationGestureLargeText");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"RotationGestureLargeText");
    });
    
    it(@"handles rotate gestures for single line text", ^{
        [textView layoutIfNeeded];
        
        UIRotationGestureRecognizer *mockRotationRecognizer = mock([UIRotationGestureRecognizer class]);
        
        [[[given([mockRotationRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockRotationRecognizer rotation])
         willReturn:@(0.75f)];
        
        [textView handlePinchOrRotateGesture:mockRotationRecognizer];
        [textView handlePinchOrRotateGesture:mockRotationRecognizer];
        [textView handlePinchOrRotateGesture:mockRotationRecognizer];
        
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"RotationGestureSingleLineText");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"RotationGestureSingleLineText");
    });
    
    it(@"handles pinch gestures for large text", ^{
        textView.fitOriginalFontSizeToViewWidth = YES;
        textView.textString = @"The quick brown fox jumped over the lazy dog.";
        textView.fontSize = 60.f;
        textView.textAlignment = NSTextAlignmentLeft;
        textView.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [textView layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(0.25f)];
        
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"PinchGestureLargeText");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"PinchGestureLargeText");
    });
    
    it(@"handles pinch gestures for single line text", ^{
        [textView layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(0.25f)];
        
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"PinchGestureSingleLineText");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"PinchGestureSingleLineText");
    });
    
    it(@"handles zoom in pinch gestures for large text", ^{
        textView.fitOriginalFontSizeToViewWidth = YES;
        textView.textString = @"The quick brown fox jumped over the lazy dog.";
        textView.fontSize = 60.f;
        textView.textAlignment = NSTextAlignmentLeft;
        textView.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [textView layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(3.f)];
        
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"PinchGestureZoomLargeText");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"PinchGestureZoomLargeText");
    });
    
    it(@"handles zoom in pinch gestures for single line text", ^{
        [textView layoutIfNeeded];
        
        UIPinchGestureRecognizer *mockPinchRecognizer = mock([UIPinchGestureRecognizer class]);
        
        [[[given([mockPinchRecognizer state])
           willReturn:@(UIGestureRecognizerStateBegan)]
          willReturn:@(UIGestureRecognizerStateChanged)]
         willReturn:@(UIGestureRecognizerStateEnded)];
        
        [given([mockPinchRecognizer scale])
         willReturn:@(3.f)];
        
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"PinchGestureZoomSingleLineText");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"PinchGestureZoomSingleLineText");
    });
    
    it(@"handles pinch zoom and pan gestures for large text", ^{
        textView.fitOriginalFontSizeToViewWidth = YES;
        textView.textString = @"The quick brown fox jumped over the lazy dog.";
        textView.fontSize = 60.f;
        textView.textAlignment = NSTextAlignmentLeft;
        textView.initialTextInsets = UIEdgeInsetsMake(20.f, 20.f, 20.f, 20.f);
        [textView layoutIfNeeded];
        
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
        
        [textView handlePanGesture:mockPanRecognizer];
        [textView handlePinchOrRotateGesture:mockRotationRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        
        [textView handlePanGesture:mockPanRecognizer];
        [textView handlePinchOrRotateGesture:mockRotationRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        
        [textView handlePanGesture:mockPanRecognizer];
        [textView handlePinchOrRotateGesture:mockRotationRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"PinchZoomPanGestureLargeText");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"PinchZoomPanGestureLargeText");
    });
    
    it(@"handles pinch zoom and pan gestures for single line text", ^{
        [textView layoutIfNeeded];
        
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
        
        [textView handlePanGesture:mockPanRecognizer];
        [textView handlePinchOrRotateGesture:mockRotationRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        
        [textView handlePanGesture:mockPanRecognizer];
        [textView handlePinchOrRotateGesture:mockRotationRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        
        [textView handlePanGesture:mockPanRecognizer];
        [textView handlePinchOrRotateGesture:mockRotationRecognizer];
        [textView handlePinchOrRotateGesture:mockPinchRecognizer];
        
#ifdef IS_RECORDING
        expect(textView).to.recordSnapshotNamed(@"PinchZoomPanGestureSingleLineText");
#endif
        expect(textView).to.haveValidSnapshotNamed(@"PinchZoomPanGestureSingleLineText");
    });
    
    it(@"doesn't crash with weird gesture recognizer state", ^{
        [textView layoutIfNeeded];
        
        UIPanGestureRecognizer *mockPanRecognizer = mock([UIPanGestureRecognizer class]);
        
        [given([mockPanRecognizer state])
         willReturn:@(UIGestureRecognizerStateFailed)];
        
        [textView handlePanGesture:mockPanRecognizer];
        [textView handlePinchOrRotateGesture:mockPanRecognizer];
    });
    
    it(@"renders text at given size", ^{
        textView.fitOriginalFontSizeToViewWidth = YES;
        textView.textString = @"The quick brown fox jumped over the lazy dog.";
        textView.fontSize = 60.f;
        textView.textAlignment = NSTextAlignmentLeft;
        
        UIImage *renderedImage = [textView renderDrawTextViewWithSize:CGSizeMake(800.f, 1200.f)];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        imageView.backgroundColor = [UIColor lightGrayColor];
        
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"RenderTextToImage");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"RenderTextToImage");
    });
    
    it(@"draws text on background image", ^{
        textView.fitOriginalFontSizeToViewWidth = YES;
        textView.textString = @"The quick brown fox jumped over the lazy dog.";
        textView.fontSize = 60.f;
        textView.textAlignment = NSTextAlignmentLeft;
        
        UIImage *testImage = [UIImage imageNamed:@"JotTestImage.png"];
        UIImage *renderedImage = [textView drawTextOnImage:testImage];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:renderedImage];
        
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"DrawTextOnBackgroundImage");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"DrawTextOnBackgroundImage");
    });
    
    afterEach(^{
        textView = nil;
    });
});

SpecEnd
