//
//  HTZoomScrollCropImageView.h
//  TestVacuum
//
//  Created by Daniel Biran on 11/25/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTZoomScrollImageView.h"

@protocol HTZoomScrollCropImageViewDelegate;

@interface HTZoomScrollCropImageView : HTZoomScrollImageView

@property (nonatomic) id<HTZoomScrollCropImageViewDelegate> delegate;

@end

@protocol HTZoomScrollCropImageViewDelegate <NSObject>

- (CGSize)htZoomScrollCropImageViewNeedsCropSize:(HTZoomScrollCropImageView *)zoomScrollCropImageView;

@end