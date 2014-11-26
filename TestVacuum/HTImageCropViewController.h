//
//  HTImageCropViewController.h
//  TestVacuum
//
//  Created by Daniel Biran on 11/24/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTImageZoomViewController.h"
#import "HTZoomScrollCropImageView.h"

@interface HTImageCropViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic) IBOutlet HTZoomScrollCropImageView *imageScrollView;

@end
