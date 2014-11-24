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
//
//  TestVacuum
//
//  Created by Daniel Biran on 11/17/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTZoomScrollView.h"
#import "HTImageZoomViewController.h"

@interface HTImageZoomViewController ()

- (void)setMinimumZoomForCurrentFrame;
- (void)setMinimumZoomForCurrentFrameAndAnimateIfNecessary;

@property (nonatomic, strong) IBOutlet HTZoomScrollView *imageScrollView;

@end

@implementation HTImageZoomViewController

@synthesize imageScrollView = _imageScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO: Use real assets
    UIImage *image = [UIImage imageNamed:@"002-bentley-continental-gt3.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    // Finish the ScrollView setup
    [self.imageScrollView setContentSize:imageView.frame.size];
    [self.imageScrollView setChildView:imageView];
    [self.imageScrollView setMaximumZoomScale:2.0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // set the frame size since the xib doesn't resize for you
    self.imageScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self setMinimumZoomForCurrentFrame];
    
    [self.imageScrollView setZoomScale:self.imageScrollView.minimumZoomScale animated:NO];
    
#ifdef DEBUG
    CGFloat scale = self.imageScrollView.zoomScale;
    NSLog(@"Scale is %f", scale);
#endif
}

// TODO: Support for rotation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    // Aspect ratio of ScrollView has changed, need to recalculate the minimum zoom
    [self setMinimumZoomForCurrentFrameAndAnimateIfNecessary];
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

- (void)scrollViewDidEndZooming:(HTZoomScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    // TODO: Remove this logging?
#ifdef DEBUG
    UIView *theView = [scrollView childView];
    NSLog(@"view frame: %@", NSStringFromCGRect(theView.frame));
    NSLog(@"view bounds: %@", NSStringFromCGRect(theView.bounds));
#endif
}

#pragma mark - Private Helpers

// Used to work out the minimum zoom, called when device rotates (as aspect ratio of ScrollView changes when this happens).
// Could become part of HTScrollView but put here for now as you may not want the same behaviour I do in this regard :)
// TODO: Move to yet another class for image zooming scroll view
- (void)setMinimumZoomForCurrentFrame {
    UIImageView *imageView = (UIImageView *)[self.imageScrollView childView];
    
    // Work out a nice minimum zoom for the image - if it's smaller than the ScrollView then 1.0x zoom otherwise a scaled down zoom so it fits in the ScrollView entirely when zoomed out
    CGSize imageSize = imageView.image.size;
    CGSize scrollSize = self.imageScrollView.frame.size;
    CGFloat widthRatio = scrollSize.width / imageSize.width;
    CGFloat heightRatio = scrollSize.height / imageSize.height;
//    CGFloat minimumZoom = MIN(1.0, (widthRatio > heightRatio) ? heightRatio : widthRatio);
    CGFloat minimumZoom = (widthRatio > heightRatio) ? heightRatio : widthRatio;
    
    self.imageScrollView.minimumZoomScale = minimumZoom;
}

- (void)setMinimumZoomForCurrentFrameAndAnimateIfNecessary {
    BOOL wasAtMinimumZoom = NO;
    
    if(self.imageScrollView.zoomScale == self.imageScrollView.minimumZoomScale) {
        wasAtMinimumZoom = YES;
    }
    
    [self setMinimumZoomForCurrentFrame];
    
    if(wasAtMinimumZoom || self.imageScrollView.zoomScale < self.imageScrollView.minimumZoomScale) {
        [self.imageScrollView setZoomScale:self.imageScrollView.minimumZoomScale animated:YES];
    }
}

@end
