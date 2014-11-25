// This class was modified from the original
// found here: https://github.com/nyoron/NYOBetterZoom

// ORIGINAL:
//
//  NYOBetterUIScrollView.m
//  ZoomTest
//
//  Created by Liam on 14/04/2010.
//  Copyright 2010 Liam Jones (nyoron.co.uk). All rights reserved.
//
// MODIFIED:
//  HTZoomScrollView.m
//  TestVacuum
//
//  Created by Daniel Biran on 11/17/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTZoomScrollView.h"


@implementation HTZoomScrollView

@synthesize childView = _childView;

#pragma mark - Initializers

- (id)initWithFrame:(CGRect)aFrame {
    if ((self = [super initWithFrame:aFrame])) {
        // Initialization code
    }
    return self;
}

- (id)initWithChildView:(UIView *)aChildView {
    if (self = [super init]) {
        [self setChildView: aChildView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)aFrame andChildView:(UIView *)aChildView  {
    if (self = [super initWithFrame:aFrame]) {
        self.childView = aChildView;
    }
    return self;
}

#pragma mark - Public Methods

- (void)setMinimumZoomForCurrentFrameAndAnimateIfNecessary {
    BOOL wasAtMinimumZoom = NO;
    
    if(self.zoomScale == self.minimumZoomScale) {
        wasAtMinimumZoom = YES;
    }
    
    [self setMinimumZoomForCurrentFrame];
    
    if(wasAtMinimumZoom || self.zoomScale < self.minimumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }
}

#pragma mark - Accessors

// This is the bread and butter to why this works for zooming the image/subview
-(void)setChildView:(UIView *)aChildView {
    @synchronized(self) {
        if (_childView != aChildView) {
            [_childView removeFromSuperview];
            _childView = aChildView;
            // call super directly here to avoid warnings (see below)
            [super addSubview:_childView];
            [self setContentOffset:CGPointZero];
        }
    }
}

#pragma mark - UIScrollView

// Rather than the default behaviour of a {0,0} offset when an image is too small
// to fill the UIScrollView we're going to return an offset that centers the image
// in the UIScrollView instead.
- (void)setContentOffset:(CGPoint)anOffset {
    if(self.childView != nil) {
        CGSize zoomViewSize = self.childView.frame.size;
        CGSize scrollViewSize = self.bounds.size;
        
        if(zoomViewSize.width < scrollViewSize.width) {
            // divide by 2 to center it
            anOffset.x = -(scrollViewSize.width - zoomViewSize.width) / 2.0;
        }
        
        if(zoomViewSize.height < scrollViewSize.height) {
            // divide by 2 to center it
            anOffset.y = -(scrollViewSize.height - zoomViewSize.height) / 2.0;
        }
    }
    
    super.contentOffset = anOffset;
}

#pragma mark - WARNING DEVELOPERS

// This data needs to be setup/adjusted when the view initially appears in the
// viewWillAppear: of the controller and when the view rotates in
// didRotateFromInterfaceOrientation: of the controller.
- (void)setMinimumZoomForCurrentFrame {
    // You must override this function in your subclass for zooming
    NSAssert(NO, @"NOT SUPPORTED TO DIRECTLY CALL THIS");
}

// Warn the programmer if they're using regular subview methods (this subclass is only designed for zooming a single view)
#ifdef DEBUG
#define SubviewMethodWarning() NSLog(@"%s warning - this class is only designed to work with a single subview via initWithFrame:andChildView: and/or the childView accessors. I won't stop you from calling this method but make sure you know the implications of what you're doing. ;)", __PRETTY_FUNCTION__);
#else
#define SubviewMethodWarning()
#endif

- (void)addSubview:(UIView *)view {
    SubviewMethodWarning();
    [super addSubview:view];
}


- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2 {
    SubviewMethodWarning();
    [super exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
}


- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview {
    SubviewMethodWarning();
    [super insertSubview:view aboveSubview:siblingSubview];
}


- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index {
    SubviewMethodWarning();
    [super insertSubview:view atIndex:index];
}


- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview {
    SubviewMethodWarning();
    [super insertSubview:view belowSubview:siblingSubview];
}


@end
