//
//  JotTextEditViewSpec.m
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
#import <jot/JotTextEditView.h>
#import <UIKit/UIKit.h>

@interface JotTextEditView () <UITextViewDelegate>

@end

SpecBegin(JotTextEditView)

describe(@"JotTextEditView", ^{
    __block JotTextEditView *textEditView;
    
    beforeEach(^{
        textEditView = [JotTextEditView new];
        textEditView.frame = CGRectMake(0.f, 0.f, 320.f, 480.f);
        textEditView.textString = @"Hello World";
        textEditView.textColor = [UIColor whiteColor];
        [textEditView layoutIfNeeded];
    });
    
    it(@"can be created", ^{
        expect(textEditView).toNot.beNil();
    });
    
    it(@"displays the string", ^{
        textEditView.isEditing = YES;
#ifdef IS_RECORDING
        expect(textEditView).to.recordSnapshotNamed(@"TextString");
#endif
        expect(textEditView).to.haveValidSnapshotNamed(@"TextString");
    });
    
    it(@"clears the string", ^{
        textEditView.isEditing = YES;
        textEditView.textString = @"";
#ifdef IS_RECORDING
        expect(textEditView).to.recordSnapshotNamed(@"Clear");
#endif
        expect(textEditView).to.haveValidSnapshotNamed(@"Clear");
    });
    
    it(@"sets the font", ^{
        textEditView.isEditing = YES;
        textEditView.font = [UIFont boldSystemFontOfSize:50.f];
#ifdef IS_RECORDING
        expect(textEditView).to.recordSnapshotNamed(@"Font");
#endif
        expect(textEditView).to.haveValidSnapshotNamed(@"Font");
    });
    
    it(@"sets the font size", ^{
        textEditView.isEditing = YES;
        textEditView.fontSize = 80.f;
#ifdef IS_RECORDING
        expect(textEditView).to.recordSnapshotNamed(@"FontSize");
#endif
        expect(textEditView).to.haveValidSnapshotNamed(@"FontSize");
    });
    
    it(@"sets the text color", ^{
        textEditView.isEditing = YES;
        textEditView.textColor = [UIColor magentaColor];
#ifdef IS_RECORDING
        expect(textEditView).to.recordSnapshotNamed(@"TextColor");
#endif
        expect(textEditView).to.haveValidSnapshotNamed(@"TextColor");
    });
    
    it(@"sets the text alignment to left", ^{
        textEditView.isEditing = YES;
        textEditView.textString = @"The quick brown fox jumped over the lazy dog.";
        textEditView.fontSize = 60.f;
        textEditView.textAlignment = NSTextAlignmentLeft;
#ifdef IS_RECORDING
        expect(textEditView).to.recordSnapshotNamed(@"TextAlignmentLeft");
#endif
        expect(textEditView).to.haveValidSnapshotNamed(@"TextAlignmentLeft");
    });
    
    it(@"sets the text alignment to center", ^{
        textEditView.isEditing = YES;
        textEditView.textString = @"The quick brown fox jumped over the lazy dog.";
        textEditView.fontSize = 60.f;
        textEditView.textAlignment = NSTextAlignmentCenter;
#ifdef IS_RECORDING
        expect(textEditView).to.recordSnapshotNamed(@"TextAlignmentCenter");
#endif
        expect(textEditView).to.haveValidSnapshotNamed(@"TextAlignmentCenter");
    });
    
    it(@"sets the text alignment to right", ^{
        textEditView.isEditing = YES;
        textEditView.textString = @"The quick brown fox jumped over the lazy dog.";
        textEditView.fontSize = 60.f;
        textEditView.textAlignment = NSTextAlignmentRight;
#ifdef IS_RECORDING
        expect(textEditView).to.recordSnapshotNamed(@"TextAlignmentRight");
#endif
        expect(textEditView).to.haveValidSnapshotNamed(@"TextAlignmentRight");
    });
    
    it(@"sets the text insets with a gradient", ^{
        textEditView.isEditing = YES;
        textEditView.textString = @"The quick brown fox jumped over the lazy dog.";
        textEditView.fontSize = 60.f;
        textEditView.textAlignment = NSTextAlignmentLeft;
        textEditView.textEditingInsets = UIEdgeInsetsMake(40.f, 40.f, 40.f, 40.f);
        [textEditView layoutIfNeeded];
#ifdef IS_RECORDING
        expect(textEditView).to.recordSnapshotNamed(@"TextInsetsGradient");
#endif
        expect(textEditView).to.haveValidSnapshotNamed(@"TextInsetsGradient");
    });
    
    it(@"sets the text insets clipped", ^{
        textEditView.isEditing = YES;
        textEditView.textString = @"The quick brown fox jumped over the lazy dog.";
        textEditView.fontSize = 60.f;
        textEditView.textAlignment = NSTextAlignmentLeft;
        textEditView.textEditingInsets = UIEdgeInsetsMake(40.f, 40.f, 40.f, 40.f);
        textEditView.clipBoundsToEditingInsets = YES;
        [textEditView layoutIfNeeded];
#ifdef IS_RECORDING
        expect(textEditView).to.recordSnapshotNamed(@"TextInsetsClipped");
#endif
        expect(textEditView).to.haveValidSnapshotNamed(@"TextInsetsClipped");
    });
    
    it(@"hides text and overlay when not in editing mode", ^{
        textEditView.isEditing = NO;
#ifdef IS_RECORDING
        expect(textEditView).to.recordSnapshotNamed(@"TextNotEditingModeHidesView");
#endif
        expect(textEditView).to.haveValidSnapshotNamed(@"TextNotEditingModeHidesView");
    });
    
    it(@"starts not in editing mode", ^{
        expect(textEditView.isEditing).to.beFalsy();
    });
    
    it(@"starts with text edit view hidden", ^{
        textEditView.isEditing = NO;
#ifdef IS_RECORDING
        expect(textEditView).to.recordSnapshotNamed(@"StartsWithViewHidden");
#endif
        expect(textEditView).to.haveValidSnapshotNamed(@"StartsWithViewHidden");
    });
    
    it(@"allows textview updates to change text string", ^{
        textEditView.isEditing = YES;
        UITextView *mockTextView = mock([UITextView class]);
        [given([mockTextView text]) willReturn:@"Hello World"];
        
        BOOL updateAllowed = [textEditView textView:mockTextView shouldChangeTextInRange:NSMakeRange(0, 5) replacementText:@"Goodbye"];
        
        expect(updateAllowed).to.beTruthy();
    });
    
    it(@"updates isEditing when done button pressed", ^{
        textEditView.isEditing = YES;
        
        UITextView *mockTextView = mock([UITextView class]);
        [given([mockTextView text]) willReturn:@"Hello World"];
        
        BOOL updateAllowed = [textEditView textView:mockTextView shouldChangeTextInRange:NSMakeRange(5, 1) replacementText:@"\n"];
        
        expect(updateAllowed).to.beFalsy();
    });
    
    it(@"doesn't allow too long updates to text string", ^{
        
        textEditView.isEditing = YES;
        
        UITextView *mockTextView = mock([UITextView class]);
        [given([mockTextView text]) willReturn:@"Hello World"];
        
        BOOL updateAllowed = [textEditView textView:mockTextView shouldChangeTextInRange:NSMakeRange(5, 1) replacementText:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."];
        
        expect(updateAllowed).to.beFalsy();
    });
    
    it(@"doesn't allow newline characters to update text string", ^{
        
        textEditView.isEditing = YES;
        
        UITextView *mockTextView = mock([UITextView class]);
        [given([mockTextView text]) willReturn:@"Hello World"];
        
        BOOL updateAllowed = [textEditView textView:mockTextView shouldChangeTextInRange:NSMakeRange(0, 5) replacementText:@"Good\nBye"];
        
        expect(updateAllowed).to.beFalsy();
    });

    afterEach(^{
        textEditView = nil;
    });
});

SpecEnd
