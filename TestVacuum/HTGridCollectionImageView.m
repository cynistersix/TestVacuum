//
//  HTGridCollectionImageView.m
//  TestVacuum
//
//  Created by Daniel Biran on 5/21/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTGridCollectionImageView.h"
#import "InnerShadowUIView.h"

@interface HTGridCollectionImageView ()

- (id)initializeImage;

@property (nonatomic, retain) IBOutlet InnerShadowUIView *shadowView;

@end

@implementation HTGridCollectionImageView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self = [self initializeImage];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        self = [self initializeImage];
    }
    
    return self;
    
}

- (id)initializeImage
{
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"HTGridCollectionImageView" owner:self options:nil];
    
    if ([arrayOfViews count] < 1) {
        return nil;
    }
    
    if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UIView class]]) {
        return nil;
    }
    
    for (UIView *view in arrayOfViews) {
        [self addSubview:view];
    }

    
    // radius and mask them seperately else the corner clips off the
    self.thumbImageView.layer.cornerRadius = 3.f;
    self.thumbImageView.layer.masksToBounds = YES;
    
    self.shadowView.layer.cornerRadius = 3.f;
    self.shadowView.layer.masksToBounds = YES;
    
    return self;
}

@end
