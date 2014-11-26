//
//  HTImageCropViewController.m
//  TestVacuum
//
//  Created by Daniel Biran on 11/24/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTImageCropViewController.h"
#import "HTCropView.h"

@interface HTImageCropViewController ()

@property (nonatomic, weak) IBOutlet HTCropView *cropWindow;

@end

@implementation HTImageCropViewController

@synthesize imageScrollView = _imageScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Keep the scrollview and view from going under the navigation bar
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidUnload {
    self.imageScrollView = nil;
}

- (void)dealloc {
    self.imageScrollView = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // set the frame size since the xib doesn't resize for you prior to rotation
    self.imageScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    // set the crop window size
    self.cropWindow.frame = self.imageScrollView.frame;
    
    [self.imageScrollView setupImage];
    
    [self.imageScrollView setMinimumZoomForCurrentFrame];
    
    // This places the image in the center of the crop window so it fits
    // where the edges hang outside the crop area
    self.imageScrollView.zoomScale = MIN(self.cropWindow.cropHeight/self.imageScrollView.imageView.image.size.height,
                                         self.cropWindow.cropWidth/self.imageScrollView.imageView.image.size.width);
}

// TODO: Support for rotation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    // Aspect ratio of ScrollView has changed, need to recalculate the minimum zoom
    [self.imageScrollView setMinimumZoomForCurrentFrameAndAnimateIfNecessary];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(HTZoomScrollView *)aScrollView {
    return aScrollView.childView;
}

- (void)scrollViewDidEndZooming:(HTZoomScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    // TODO: Remove this logging?
#ifdef DEBUG
    UIView *theView = [scrollView childView];
    NSLog(@"%s - view frame: %@", __PRETTY_FUNCTION__, NSStringFromCGRect(theView.frame));
    NSLog(@"%s - view bounds: %@", __PRETTY_FUNCTION__, NSStringFromCGRect(theView.bounds));
#endif
}

// keep the view from decellerating the scrolls
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    
    CGFloat horizontalEdge = (self.view.bounds.size.width - self.imageScrollView.cropWindow.cropWidth)/2.f;
    CGFloat verticalEdge = (self.view.bounds.size.height - self.imageScrollView.cropWindow.cropHeight)/2.f;
    
    // TODO: Account for the size of the crop controller
    if (offset.x < 0 - horizontalEdge) {
        // Scrolled off the right of the screen
        offset.x = 0.f - horizontalEdge;
    }
    else if (offset.x > (self.imageScrollView.contentSize.width - self.imageScrollView.frame.size.width + horizontalEdge)) {
        // Scrolled off the left of the screen
        offset.x = (self.imageScrollView.contentSize.width - self.imageScrollView.frame.size.width + horizontalEdge);
    }
    
    if (offset.y < 0 - verticalEdge) {
        // Scrolled off the top of the screen
        offset.y = 0.f - verticalEdge;
    }
    else if (offset.y > (self.imageScrollView.contentSize.height - self.imageScrollView.frame.size.height + verticalEdge)) {
        // Scrolled off the bottom of the screen
        offset.y = (self.imageScrollView.contentSize.height - self.imageScrollView.frame.size.height + verticalEdge);
    }
    
    [scrollView setContentOffset:offset animated:YES];
}

@end
