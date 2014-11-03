//
//  HTGridCollectionHeaderView.h
//  TestVacuum
//
//  Created by Daniel Biran on 11/2/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTGridCollectionToggleView.h"

@protocol HTGridCollectionToggleHeaderDelegate;

@interface HTGridCollectionHeaderView : UICollectionReusableView <HTGridCollectionToggleViewDelegate>

- (void)toggleToGridView:(BOOL)gridView;

@property (nonatomic, retain) IBOutlet HTGridCollectionToggleView *gridListToggleHeaderView;
@property (nonatomic, assign) id<HTGridCollectionToggleHeaderDelegate> delegate;

@end

@protocol HTGridCollectionToggleHeaderDelegate <NSObject>

@optional
- (void)htGridCollectionToggleHeader:(HTGridCollectionHeaderView *)cell willToggleToGrid:(BOOL)gridView;
- (void)htGridCollectionToggleHeader:(HTGridCollectionHeaderView *)cell didToggleToGrid:(BOOL)gridView;

@end
