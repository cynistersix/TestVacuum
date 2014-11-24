//
//  HTZoomScrollView.m
//  TestVacuum
//
//  Created by Daniel Biran on 11/23/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTZoomScrollView.h"

@implementation HTZoomScrollView

- (void)dealloc {
    self.childView = nil;
}

// Borrowed from:
//
// https://github.com/nyoron/NYOBetterZoom

#pragma mark -
#pragma mark UIScrollView

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    NSLog(@"DANIEL - %s", __PRETTY_FUNCTION__);
}

// Rather than the default behaviour of a {0,0} offset when an image is too small to fill the UIScrollView we're going to return an offset that centres the image in the UIScrollView instead.
- (void)setContentOffset:(CGPoint)anOffset {
    if(_childView != nil) {
        CGSize zoomViewSize = _childView.frame.size;
        CGSize scrollViewSize = self.bounds.size;
        
        if(zoomViewSize.width < scrollViewSize.width) {
            anOffset.x = -(scrollViewSize.width - zoomViewSize.width) / 2.0;
        }
        
        if(zoomViewSize.height < scrollViewSize.height) {
            anOffset.y = -(scrollViewSize.height - zoomViewSize.height) / 2.0;
        }
    }
    
    super.contentOffset = anOffset;
}


@end
