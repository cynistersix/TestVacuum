//
//  HTZoomScrollCropImageView.m
//  TestVacuum
//
//  Created by Daniel Biran on 11/25/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTZoomScrollCropImageView.h"

@implementation HTZoomScrollCropImageView

@synthesize childView = _childView;

#pragma mark - Initializers

#pragma mark - Initializers

- (id)initWithFrame:(CGRect)aFrame {
    if ((self = [super initWithFrame:aFrame])) {
        // Initialization code
    }
    return self;
}

- (id)initWithChildView:(UIView *)aChildView {
    if (self = [super init]) {
        self.childView = aChildView;
    }
    return self;
}

- (id)initWithFrame:(CGRect)aFrame andChildView:(UIView *)aChildView  {
    if (self = [super initWithFrame:aFrame]) {
        self.childView = aChildView;
    }
    return self;
}

#pragma mark - Accessors

- (UIImage *)image {
    UIImage *retVal = nil;
    
    if ([self.childView isKindOfClass:[UIView class]] &&
        [self.childView.subviews count] > 0 &&
        [self.childView.subviews[0] isKindOfClass:[UIImageView class]]) {
        retVal = [(UIImageView *)self.childView.subviews[0] image];
    }
    
    return retVal;
}

// This is the bread and butter to why this works for zooming the image/subview
-(void)setChildView:(UIImageView *)aChildView {
    @synchronized(self) {
        if (_childView != aChildView) {
            [_childView removeFromSuperview];
            
            // Need to put the image in the center of an invisible square so we can get to all corners at any size
            CGRect childFrame = aChildView.frame;
            CGFloat squareWidth = MAX(childFrame.size.width, childFrame.size.height);
            CGRect squareFrame = CGRectMake(childFrame.origin.x,
                                            childFrame.origin.y,
                                            squareWidth,
                                            squareWidth);
            
            UIView *view = [[UIView alloc] initWithFrame:squareFrame];
            [view addSubview:aChildView];

            // center the image
            aChildView.center = view.center;
            
            // lastly set the childView as the square inside the scrolling view
            _childView = view;
            
            // call super directly here to avoid warnings (see below)
            [super addSubview:_childView];
            [self setContentOffset:CGPointMake((childFrame.size.width - _childView.frame.size.width)/2.f,
                                               (childFrame.size.height - _childView.frame.size.height)/2.f)];
        }
    }
}

#pragma mark - Public Methods

// Used to work out the minimum zoom, called when device rotates (as aspect ratio of ScrollView changes when this happens).
// Could become part of HTScrollView but put here for now as you may not want the same behaviour I do in this regard :)
- (void)setMinimumZoomForCurrentFrame {
    
    UIView *imageView = (UIView *)[self childView];
    
    // Work out a nice minimum zoom for the image - if it's smaller than the ScrollView then 1.0x zoom otherwise a scaled down zoom so it fits in the ScrollView entirely when zoomed out
    CGSize imageSize = imageView.frame.size;
    CGSize scrollSize = self.frame.size;
    CGFloat widthRatio = scrollSize.width / imageSize.width;
    CGFloat heightRatio = scrollSize.height / imageSize.height;
    
    // if you set minimum to 1 the large images will show full scale which is wrong.
    CGFloat minimumZoom = (widthRatio > heightRatio) ? heightRatio : widthRatio;
    
    // if being cropped we need to be able to fit the entire image in the square
    if ([self.delegate respondsToSelector:@selector(htZoomScrollCropImageViewNeedsCropSize:)]) {
        CGSize cropSize = [self.delegate htZoomScrollCropImageViewNeedsCropSize:self];
        
        minimumZoom = minimumZoom * MAX(cropSize.width/scrollSize.width, cropSize.height/scrollSize.height);
    }
    
    self.minimumZoomScale = minimumZoom;
}

@end
