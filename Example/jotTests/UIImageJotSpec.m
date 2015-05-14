//
//  UIImageJotSpec.m
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
#import <UIImage+Jot.h>

SpecBegin(UIImageJot)

describe(@"UIImageJot", ^{
    __block UIImage *image;
    __block UIImage *translucentImage;
    
    beforeAll(^{
        image = [UIImage jotImageWithColor:[UIColor redColor]
                                      size:CGSizeMake(100.f, 200.f)];
        translucentImage = [UIImage jotImageWithColor:[[UIColor cyanColor] colorWithAlphaComponent:0.5f]
                                                 size:CGSizeMake(200.f, 300.f)];
    });
    
    it(@"can be created", ^{
        expect(image).toNot.beNil();
        expect(translucentImage).toNot.beNil();
    });
    
    it(@"returns the correct size", ^{
        expect(image.size.width).to.equal(100.f);
        expect(image.size.height).to.equal(200.f);
        expect(translucentImage.size.width).to.equal(200.f);
        expect(translucentImage.size.height).to.equal(300.f);
    });
    
    it(@"returns the correct scale", ^{
        expect(image.scale).to.equal([UIScreen mainScreen].scale);
        expect(translucentImage.scale).to.equal([UIScreen mainScreen].scale);
    });
    
    it(@"correctly draws a solid colored image", ^{
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"SolidColoredImage");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"SolidColoredImage");
    });
    
    it(@"correctly draws a translucent colored image", ^{
        UIImageView *imageView = [[UIImageView alloc] initWithImage:translucentImage];
#ifdef IS_RECORDING
        expect(imageView).to.recordSnapshotNamed(@"TranslucentColoredImage");
#endif
        expect(imageView).to.haveValidSnapshotNamed(@"TranslucentColoredImage");
    });
    
    afterAll(^{
        image = nil;
    });
});

SpecEnd
