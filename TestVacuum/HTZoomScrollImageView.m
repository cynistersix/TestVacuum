//
//  HTZoomScrollImageView.m
//  TestVacuum
//
//  Created by Daniel Biran on 11/24/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTZoomScrollImageView.h"

@implementation HTZoomScrollImageView

#pragma mark - Accessors

- (UIImage *)image {
    UIImage *retVal = nil;
    
    if ([self.childView isKindOfClass:[UIImageView class]]) {
        retVal = [(UIImageView *)self.childView image];
    }
    
    return retVal;
}

#pragma mark - Public Methods

- (void)setupImage {
    // TODO: Use real assets
    UIImage *image = [UIImage imageNamed:@"002-bentley-continental-gt3.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    // Finish the ScrollView setup
    [self setContentSize:imageView.frame.size];
    [self setChildView:imageView];
    [self setMaximumZoomScale:2.0];
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
