// This class was modified from the original
// found here: https://github.com/nyoron/NYOBetterZoom

// ORIGINAL:
//
//  NYOBetterZoomViewController.m
//  NYOBetterZoom
//
//  Created by Liam on 14/04/2010.
//  Copyright Liam Jones (nyoron.co.uk) 2010. All rights reserved.
//
// MODIFIED:
//  HTImageZoomViewController.m
//  TestVacuum
//
//  Created by Daniel Biran on 11/17/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTImageZoomViewController.h"

@implementation HTImageZoomViewController

@synthesize imageScrollView = _imageScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Keep the scrollview and view from going under the navigation bar
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.imageScrollView setupImage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // set the frame size since the xib doesn't resize for you prior to rotation
    self.imageScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.imageScrollView setMinimumZoomForCurrentFrame];
    
    [self.imageScrollView setZoomScale:self.imageScrollView.minimumZoomScale animated:NO];
    
#ifdef DEBUG
    CGFloat scale = self.imageScrollView.zoomScale;
    NSLog(@"Scale is %f", scale);
#endif
}

// TODO: Support for rotation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    // Aspect ratio of ScrollView has changed, need to recalculate the minimum zoom
    [self.imageScrollView setMinimumZoomForCurrentFrameAndAnimateIfNecessary];
}

- (void)viewDidUnload {
    self.imageScrollView = nil;
}

- (void)dealloc {
    self.imageScrollView = nil;
}

#pragma mark UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(HTZoomScrollView *)aScrollView {
    return aScrollView.childView;
}

// keep the view from decellerating the scrolls
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    
    // TODO: Account for the size of the crop controller
    if (offset.x < 0) {
        // Scrolled off the right of the screen
        offset.x = 0.f;
    }
    else if (offset.x > (self.imageScrollView.contentSize.width - self.imageScrollView.frame.size.width)) {
        // Scrolled off the left of the screen
        offset.x = (self.imageScrollView.contentSize.width - self.imageScrollView.frame.size.width);
    }
    
    if (offset.y < 0) {
        // Scrolled off the right of the screen
        offset.y = 0.f;
    }
    else if (offset.y > (self.imageScrollView.contentSize.height - self.imageScrollView.frame.size.height)) {
        // Scrolled off the left of the screen
        offset.y = (self.imageScrollView.contentSize.height - self.imageScrollView.frame.size.height);
    }
    
    [scrollView setContentOffset:offset animated:YES];
}

- (void)scrollViewDidEndZooming:(HTZoomScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    // TODO: Remove this logging?
#ifdef DEBUG
    UIView *theView = [scrollView childView];
    NSLog(@"%s - view frame: %@", __PRETTY_FUNCTION__, NSStringFromCGRect(theView.frame));
    NSLog(@"%s - view bounds: %@", __PRETTY_FUNCTION__, NSStringFromCGRect(theView.bounds));
#endif
}

@end
