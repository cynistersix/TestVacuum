//
//  HTZoomScrollCropImageView.h
//  TestVacuum
//
//  Created by Daniel Biran on 11/25/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTZoomScrollImageView.h"
#import "HTCropView.h"

@interface HTZoomScrollCropImageView : HTZoomScrollImageView

// TODO: Add this in code
@property (nonatomic) IBOutlet HTCropView *cropWindow;

@end