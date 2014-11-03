//
//  HTGridCollectionHeaderView.m
//  TestVacuum
//
//  Created by Daniel Biran on 11/2/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTGridCollectionHeaderView.h"

@implementation HTGridCollectionHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"HTGridCollectionHeaderView" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionReusableView class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    
    return self;
}

- (void)toggleToGridView:(BOOL)gridView
{
    [self.gridListToggleHeaderView toggleToGridView:gridView];
}

- (void)htGridCollectionToggleView:(HTGridCollectionToggleView *)toggleView willToggleToGrid:(BOOL)gridView
{
    if ([self.delegate respondsToSelector:@selector(htGridCollectionToggleHeader:willToggleToGrid:)]) {
        [self.delegate htGridCollectionToggleHeader:self didToggleToGrid:gridView];
    }
}

- (void)htGridCollectionToggleView:(HTGridCollectionToggleView *)toggleView didToggleToGrid:(BOOL)gridView
{
    if ([self.delegate respondsToSelector:@selector(htGridCollectionToggleHeader:didToggleToGrid:)]) {
        [self.delegate htGridCollectionToggleHeader:self didToggleToGrid:gridView];
    }
}

@end
