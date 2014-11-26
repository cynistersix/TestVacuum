//
//  HTZoomScrollCropImageView.m
//  TestVacuum
//
//  Created by Daniel Biran on 11/25/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTZoomScrollCropImageView.h"

@interface HTZoomScrollCropImageView ()
{
    dispatch_once_t oncePerAppearanceToken;
}

@end

@implementation HTZoomScrollCropImageView

#pragma mark - UIScrollView

- (void)setZoomScale:(CGFloat)scale animated:(BOOL)animated {
    
    [super setZoomScale:scale animated:animated];
    
    dispatch_once(&oncePerAppearanceToken, ^{
        // center it when we setup the image
        CGPoint anOffset = self.contentOffset;
        CGSize zoomViewSize = self.childView.frame.size;
        CGSize scrollViewSize = self.cropWindow.cropRect.size;
        
        if (zoomViewSize.width > scrollViewSize.width) {
            anOffset.x = -(scrollViewSize.width - zoomViewSize.width) / 2.0;
        }
        
        if(zoomViewSize.height > scrollViewSize.height) {
            // divide by 2 to center it
            anOffset.y = -(scrollViewSize.height - zoomViewSize.height) / 2.0;
        }
        
        [self setSuperContentOffset:anOffset];
    });
}

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
    
    [self setSuperContentOffset:anOffset];
}

@end
