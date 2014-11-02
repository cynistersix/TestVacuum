//
//  InnerShadowUIView.m
//  TestVacuum
//
//  Created by Daniel Biran on 5/21/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "InnerShadowUIView.h"

const CGFloat kRedLevelShadow = 0.f;
const CGFloat kGreenLevelShadow = 0.f;
const CGFloat kBlueLevelShadow = 0.f;
const CGFloat kAlphaLevelShadow = 0.5f;
const CGFloat kShadowWidth = 0.5f;

@interface InnerShadowUIView ()

- (void)drawInnerShadowWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end

// This view has a required corner radius to get the effect desired
@implementation InnerShadowUIView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self drawInnerShadowWithRed:kRedLevelShadow green:kGreenLevelShadow blue:kBlueLevelShadow alpha:kAlphaLevelShadow];
}

// Taken from : http://stackoverflow.com/questions/4431292/inner-shadow-effect-on-uiview-layer and modified
- (void)drawInnerShadowWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    CGRect bounds = [self bounds];
    CGFloat radius = self.layer.cornerRadius;
    CGRect innerRect = CGRectInset(bounds, radius, radius);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, red, green, blue, alpha);
    CGContextSetLineWidth(context, kShadowWidth);
    
    CGContextBeginPath(context);
    
    CGMutablePathRef visiblePath = CGPathCreateMutable();
    
    CGPathMoveToPoint(visiblePath, NULL, innerRect.origin.x, bounds.origin.y);
    CGPathAddLineToPoint(visiblePath, NULL, innerRect.origin.x + innerRect.size.width, bounds.origin.y);
    CGPathAddArcToPoint(visiblePath, NULL, bounds.origin.x + bounds.size.width, bounds.origin.y, bounds.origin.x + bounds.size.width, innerRect.origin.y, radius);
    CGPathAddLineToPoint(visiblePath, NULL, bounds.origin.x + bounds.size.width, innerRect.origin.y + innerRect.size.height);
    CGPathAddArcToPoint(visiblePath, NULL,  bounds.origin.x + bounds.size.width, bounds.origin.y + bounds.size.height, innerRect.origin.x + innerRect.size.width, bounds.origin.y + bounds.size.height, radius);
    CGPathAddLineToPoint(visiblePath, NULL, innerRect.origin.x, bounds.origin.y + bounds.size.height);
    CGPathAddArcToPoint(visiblePath, NULL,  bounds.origin.x, bounds.origin.y + bounds.size.height, bounds.origin.x, innerRect.origin.y + innerRect.size.height, radius);
    CGPathAddLineToPoint(visiblePath, NULL, bounds.origin.x, innerRect.origin.y);
    CGPathAddArcToPoint(visiblePath, NULL,  bounds.origin.x, bounds.origin.y, innerRect.origin.x, bounds.origin.y, radius);
    CGPathCloseSubpath(visiblePath);
    
    CGContextAddPath(context, visiblePath);
    
    CGContextStrokePath(context);
}

@end
