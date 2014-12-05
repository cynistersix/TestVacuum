//
//  HTCropView.h
//  TestVacuum
//
//  Created by Daniel Biran on 11/24/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTCropView : UIView

@property (nonatomic) CGFloat cropHeight;
@property (nonatomic) CGFloat cropWidth;
@property (nonatomic, strong) UIColor *cropMaskColor;
@property (nonatomic,readonly) CGRect cropRect;

@end
