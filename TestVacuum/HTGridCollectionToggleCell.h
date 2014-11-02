//
//  HTGridCollectionToggleCollectionCell.h
//  TestVacuum
//
//  Created by Daniel Biran on 5/23/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTGridCollectionToggleView.h"

@protocol HTGridCollectionToggleCellDelegate;

@interface HTGridCollectionToggleCell : UICollectionViewCell <HTGridCollectionToggleViewDelegate>

- (void)toggleToGridView:(BOOL)gridView;

@property (nonatomic, assign) id<HTGridCollectionToggleCellDelegate> delegate;

@end

@protocol HTGridCollectionToggleCellDelegate <NSObject>

@optional
- (void)htGridCollectionToggleCell:(HTGridCollectionToggleCell *)cell willToggleToGrid:(BOOL)gridView;
- (void)htGridCollectionToggleCell:(HTGridCollectionToggleCell *)cell didToggleToGrid:(BOOL)gridView;

@end
