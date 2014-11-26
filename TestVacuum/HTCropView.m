//
//  HTCropView.m
//  TestVacuum
//
//  Created by Daniel Biran on 11/24/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTCropView.h"

@interface HTCropView ()

- (void)initCropMask;
- (void)addMaskToLayer;

@end

@implementation HTCropView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // Do something
        [self initCropMask];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Do something
        [self initCropMask];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self addMaskToLayer];
}

- (void)initCropMask {
    self.cropMaskColor = self.backgroundColor;
    self.cropWidth = 200;
    self.cropHeight = 200;
    [self addMaskToLayer];
}

- (void)addMaskToLayer {
    CGRect bounds = self.bounds;
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.fillColor = self.cropMaskColor.CGColor;
    
    _cropRect = CGRectMake(CGRectGetMidX(bounds) - self.cropHeight/2.f,
                          CGRectGetMidY(bounds) - self.cropWidth/2.f,
                          self.cropWidth, self.cropHeight);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:_cropRect];
    [path appendPath:[UIBezierPath bezierPathWithRect:bounds]];
    
    maskLayer.path = path.CGPath;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    
    self.layer.mask = maskLayer;
}

@end
