//
//  HTGridListToggleCollectionCell.m
//  TestVacuum
//
//  Created by Daniel Biran on 5/23/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTGridCollectionToggleCell.h"

@interface HTGridCollectionToggleCell ()

@property (nonatomic, retain) IBOutlet HTGridCollectionToggleView *gridListToggleView;

@end

@implementation HTGridCollectionToggleCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"HTGridCollectionToggleCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    
    return self;
}

- (void)toggleToGridView:(BOOL)gridView
{
    [self.gridListToggleView toggleToGridView:gridView];
}

- (void)htGridCollectionToggleView:(HTGridCollectionToggleView *)toggleView willToggleToGrid:(BOOL)gridView
{
    if ([self.delegate respondsToSelector:@selector(htGridCollectionToggleCell:willToggleToGrid:)]) {
        [self.delegate htGridCollectionToggleCell:self didToggleToGrid:gridView];
    }
}

- (void)htGridCollectionToggleView:(HTGridCollectionToggleView *)toggleView didToggleToGrid:(BOOL)gridView
{
    if ([self.delegate respondsToSelector:@selector(htGridCollectionToggleCell:didToggleToGrid:)]) {
        [self.delegate htGridCollectionToggleCell:self didToggleToGrid:gridView];
    }
}

@end
