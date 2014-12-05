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

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // create view
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // create view
    }
    
    return self;
}

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

// Used to work out the minimum zoom, called when device rotates (as aspect ratio of ScrollView changes when this happens).
// Could become part of HTScrollView but put here for now as you may not want the same behaviour I do in this regard :)
- (void)setMinimumZoomForCurrentFrame {
    NSAssert([self.childView isKindOfClass:[UIImageView class]], @"Child must be of kind UIImageView to use this class for zooming");
    
    UIImageView *imageView = (UIImageView *)[self childView];
    
    // Work out a nice minimum zoom for the image - if it's smaller than the ScrollView then 1.0x zoom otherwise a scaled down zoom so it fits in the ScrollView entirely when zoomed out
    CGSize imageSize = imageView.image.size;
    CGSize scrollSize = self.frame.size;
    CGFloat widthRatio = scrollSize.width / imageSize.width;
    CGFloat heightRatio = scrollSize.height / imageSize.height;
    
    // if you set minimum to 1 the large images will show full scale which is wrong.
    CGFloat minimumZoom = (widthRatio > heightRatio) ? heightRatio : widthRatio;
    
    self.minimumZoomScale = minimumZoom;
}

@end
