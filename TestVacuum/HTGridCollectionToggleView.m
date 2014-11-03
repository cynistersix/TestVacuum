//
//  HTGridCollectionImageView.m
//  TestVacuum
//
//  Created by Daniel Biran on 5/21/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTGridCollectionToggleView.h"

@interface HTGridCollectionToggleView ()

- (id)initializeView;
- (void)buttonAction:(BOOL)gridView;
- (IBAction)gridButtonAction:(id)sender;
- (IBAction)listButtonAction:(id)sender;

@property (nonatomic, retain) IBOutlet UIButton *gridButton;
@property (nonatomic, retain) IBOutlet UIButton *listButton;

@end

@implementation HTGridCollectionToggleView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self = [self initializeView];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        self = [self initializeView];
    }
    
    return self;
    
}

- (id)initializeView
{
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"HTGridCollectionToggleView" owner:self options:nil];
    
    if ([arrayOfViews count] < 1) {
        return nil;
    }
    
    if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UIView class]]) {
        return nil;
    }
    
    for (UIView *view in arrayOfViews) {
        [self addSubview:view];
    }
    
    [self.gridButton setImage:[UIImage imageNamed:@"icon-sort-grid-active"] forState:UIControlStateSelected];
    [self.gridButton setImage:[UIImage imageNamed:@"icon-sort-grid"] forState:UIControlStateNormal];
    
    [self.listButton setImage:[UIImage imageNamed:@"icon-sort-list-active"] forState:UIControlStateSelected];
    [self.listButton setImage:[UIImage imageNamed:@"icon-sort-list"] forState:UIControlStateNormal];
    
    [self.gridButton addTarget:self action:@selector(gridButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.listButton addTarget:self action:@selector(listButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (IBAction)gridButtonAction:(id)sender
{
    [self buttonAction:YES];
}

- (IBAction)listButtonAction:(id)sender
{
    [self buttonAction:NO];
}

- (void)buttonAction:(BOOL)gridView
{
    [self.delegate htGridCollectionToggleView:self willToggleToGrid:gridView];
    
    [self toggleToGridView:gridView];
    
    [self.delegate htGridCollectionToggleView:self didToggleToGrid:gridView];
}

- (void)toggleToGridView:(BOOL)gridView
{
    self.gridButton.selected = gridView;
    self.listButton.selected = !gridView;
}

@end
