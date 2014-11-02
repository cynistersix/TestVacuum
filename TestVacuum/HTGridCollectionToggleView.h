//
//  HTGridCollectionToggleView.h
//  TestVacuum
//
//  Created by Daniel Biran on 5/21/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTGridCollectionToggleViewDelegate;

@interface HTGridCollectionToggleView : UIView

- (void)toggleToGridView:(BOOL)gridView;

@property (nonatomic, assign) IBOutlet id<HTGridCollectionToggleViewDelegate> delegate;

@end

@protocol HTGridCollectionToggleViewDelegate <NSObject>

- (void)htGridCollectionToggleView:(HTGridCollectionToggleView *)toggleView willToggleToGrid:(BOOL)gridView;
- (void)htGridCollectionToggleView:(HTGridCollectionToggleView *)toggleView didToggleToGrid:(BOOL)gridView;

@end