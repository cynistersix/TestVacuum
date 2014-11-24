// This class was modified from the original
// found here: https://github.com/nyoron/NYOBetterZoom
//
//  ORIGINAL:
//
//  NYOBetterUIScrollView.h
//  ZoomTest
//
//  Created by Liam on 14/04/2010.
//  Copyright 2010 Liam Jones (nyoron.co.uk). All rights reserved.
//
// MODIFIED:
//  HTZoomScrollView.h
//  TestVacuum
//
//  Created by Daniel Biran on 11/17/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTZoomScrollView : UIScrollView

@property (nonatomic, strong) IBOutlet UIView *childView;

- (id)initWithChildView:(UIView *)aChildView;
- (id)initWithFrame:(CGRect)aFrame andChildView:(UIView *)aChildView;

- (void)setMinimumZoomForCurrentFrameAndAnimateIfNecessary;
- (void)setMinimumZoomForCurrentFrame;

@end