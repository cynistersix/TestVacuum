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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // set the crop window size
    self.cropWindow.frame = self.imageScrollView.frame;
}

#pragma mark - UIScrollViewDelegate

// keep the view from decellerating the scrolls
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    
    CGFloat horizontalEdge = (self.view.bounds.size.width - self.cropWindow.width)/2.f;
    CGFloat verticalEdge = (self.view.bounds.size.height - self.cropWindow.height)/2.f;
    
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
