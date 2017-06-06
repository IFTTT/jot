//
//  ExampleViewController.m
//  jot
//
//  Created by Laura Skelton on 4/30/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

#import "ExampleViewController.h"
@import AssetsLibrary;
#import <Masonry/Masonry.h>
#import <jot/jot.h>

NSString * const kPencilImageName = @"";
NSString * const kTextImageName = @"";
NSString * const kClearImageName = @"";
NSString * const kSaveImageName = @"";

@interface ExampleViewController () <JotViewControllerDelegate>

@property (nonatomic, strong) JotViewController *jotViewController;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) UIButton *toggleDrawingButton;

@end

@implementation ExampleViewController

- (instancetype)init
{
    if ((self = [super init])) {
        
        _jotViewController = [JotViewController new];
        
        self.jotViewController.delegate = self;
        self.jotViewController.state = JotViewStateDrawing;
        self.jotViewController.textColor = [UIColor blackColor];
        self.jotViewController.font = [UIFont boldSystemFontOfSize:64.f];
        self.jotViewController.fontSize = 64.f;
        self.jotViewController.textEditingInsets = UIEdgeInsetsMake(12.f, 6.f, 0.f, 6.f);
        self.jotViewController.initialTextInsets = UIEdgeInsetsMake(6.f, 6.f, 6.f, 6.f);
        self.jotViewController.fitOriginalFontSizeToViewWidth = YES;
        self.jotViewController.textAlignment = NSTextAlignmentLeft;
        self.jotViewController.drawingColor = [UIColor cyanColor];
        
        _saveButton = [UIButton new];
        self.saveButton.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:24.f];
        [self.saveButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.saveButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [self.saveButton setTitle:kSaveImageName forState:UIControlStateNormal];
        [self.saveButton addTarget:self
                            action:@selector(saveButtonAction)
                  forControlEvents:UIControlEventTouchUpInside];
        
        _clearButton = [UIButton new];
        self.clearButton.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:24.f];
        [self.clearButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.clearButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [self.clearButton setTitle:kClearImageName forState:UIControlStateNormal];
        [self.clearButton addTarget:self
                             action:@selector(clearButtonAction)
                   forControlEvents:UIControlEventTouchUpInside];
        
        _toggleDrawingButton = [UIButton new];
        self.toggleDrawingButton.titleLabel.font = [UIFont fontWithName:@"FontAwesome" size:24.f];
        [self.toggleDrawingButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.toggleDrawingButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [self.toggleDrawingButton setTitle:kTextImageName forState:UIControlStateNormal];
        [self.toggleDrawingButton addTarget:self
                                     action:@selector(toggleDrawingButtonAction)
                           forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:self.jotViewController];
    [self.view addSubview:self.jotViewController.view];
    [self.jotViewController didMoveToParentViewController:self];
    [self.jotViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.saveButton];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.equalTo(@44);
        make.right.equalTo(self.view).offset(-4.f);
        make.top.equalTo(self.view).offset(4.f);
    }];
    
    [self.view addSubview:self.clearButton];
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.equalTo(@44);
        make.left.equalTo(self.view).offset(4.f);
        make.top.equalTo(self.view).offset(4.f);
    }];
    
    [self.view addSubview:self.toggleDrawingButton];
    [self.toggleDrawingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.and.width.equalTo(@44);
        make.right.equalTo(self.view).offset(-4.f);
        make.bottom.equalTo(self.view).offset(-4.f);
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.jotViewController.state == JotViewStateText) {
        self.jotViewController.state = JotViewStateEditingText;
    }
}

#pragma mark - Actions

- (void)clearButtonAction
{
    [self.jotViewController clearAll];
}

- (void)saveButtonAction
{
    UIImage *drawnImage = [self.jotViewController renderImageWithScale:2.f
                                                               onColor:self.view.backgroundColor];
    
    [self.jotViewController clearAll];
    
    ALAssetsLibrary *library = [ALAssetsLibrary new];
    [library writeImageToSavedPhotosAlbum:[drawnImage CGImage]
                              orientation:(ALAssetOrientation)[drawnImage imageOrientation]
                          completionBlock:^(NSURL *assetURL, NSError *error){
                              if (error) {
                                  NSLog(@"Error saving photo: %@", error.localizedDescription);
                              } else {
                                  NSLog(@"Saved photo to saved photos album.");
                              }
                          }];
}

- (void)toggleDrawingButtonAction
{
    if (self.jotViewController.state == JotViewStateDrawing) {
        [self.toggleDrawingButton setTitle:kPencilImageName forState:UIControlStateNormal];
        
        if (self.jotViewController.textString.length == 0) {
            self.jotViewController.state = JotViewStateEditingText;
        } else {
            self.jotViewController.state = JotViewStateText;
        }
        
    } else if (self.jotViewController.state == JotViewStateText) {
        self.jotViewController.state = JotViewStateDrawing;
        self.jotViewController.drawingColor = [UIColor colorWithRed:((double)arc4random()/UINT32_MAX) green:((double)arc4random()/UINT32_MAX) blue:((double)arc4random()/UINT32_MAX) alpha:1.0];
        [self.toggleDrawingButton setTitle:kTextImageName forState:UIControlStateNormal];
    }
}

#pragma mark - JotViewControllerDelegate

- (void)jotViewController:(JotViewController *)jotViewController isEditingText:(BOOL)isEditing
{
    self.clearButton.hidden = isEditing;
    self.saveButton.hidden = isEditing;
    self.toggleDrawingButton.hidden = isEditing;
}

@end
