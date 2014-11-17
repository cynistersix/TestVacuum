//
//  HTGridCollectionViewController.m
//  TestVacuum
//
//  Created by Daniel Biran on 5/19/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTGridCollectionViewController.h"
#import "HTGridCollectionViewCell.h"

@interface HTGridCollectionViewController ()

@property (nonatomic, retain) NSArray *items;
@property (nonatomic, retain) IBOutlet UICollectionView *collectionView;

@end

@implementation HTGridCollectionViewController

const float kToggleCellHeight = 50.f;
const float kGridCellWidthPortrait = 144.f;
const float kGridCellHeightPortrait = 188.f;

// This is now in the header

const NSUInteger kGridListViewItemsSection = 0;
const NSUInteger kNumberOfSectionsSupported = 1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _items = nil;
    }
    return self;
}

// storyboard load
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // TODO: Re-add to load from xib when integrated
//        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
  
        // TODO: REMOVE THIS IN FINAL VERSION THIS IS TEST DATA
        _items = @[ @"one", @"two", @"3", @"4", @"5", @"6"];
        // scrollable
//        _items = @[ @"one", @"two", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // register the cell nib
    [self.collectionView registerClass:[HTGridCollectionViewCell class] forCellWithReuseIdentifier:@"cellForFile"];
    [self.collectionView registerClass:[HTGridCollectionToggleCell class] forCellWithReuseIdentifier:@"cellForToggle"];
    
    // set the collection view flow layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // use the cell size
    [flowLayout setItemSize:CGSizeMake(kGridCellWidthPortrait, kGridCellHeightPortrait)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(10.f, 10.f, 40.f, 10.f);
    flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, kToggleCellHeight);
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    // setup header
    [self.collectionView registerClass:[HTGridCollectionHeaderView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:@"HeaderView"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:kGridListViewItemsSection]
                                atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    
    // TODO: Handle content size change per UX design
    // TODO: UX to redesign this completely as spec is missing
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSAssert (section == 0, @"Only 1 section is supported at this time");
    
    return [_items count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return kNumberOfSectionsSupported;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    NSAssert(section == 0, @"Only 1 section is supported at this time");
    
    return CGSizeMake(self.view.frame.size.width, kToggleCellHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout  *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(indexPath.section == 0, @"Only 1 section is supported at this time");
    
    return CGSizeMake(kGridCellWidthPortrait, kGridCellHeightPortrait);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    NSAssert(section == 0, @"Only 1 section is supported at this time");
    
    return UIEdgeInsetsMake(0.f, 10.f, 10.f, 10.f);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(indexPath.section == 0, @"Only 1 section is supported at this time");
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        HTGridCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];

        reusableview = headerView;
        headerView.delegate = self;
        
        // TODO: Use the state set in the NSUserDefaults
        [headerView toggleToGridView:YES];
    }
    
    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(indexPath.section == 0, @"Only 1 section is supported at this time");
    
    HTGridCollectionViewCell *cell = nil;
    
    cell = (HTGridCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellForFile" forIndexPath:indexPath];
    
    // TODO: REMOVE CellNum property and field this is TEST DATA
    cell.cellNum.text = [NSString stringWithFormat:@"%li", (long)indexPath.row];
    
    // just some sample data to display the capabilities of this UI
    if ((indexPath.row+1) % 3 == 0) {
        // Default file icon handling
        [cell setDefaultFileType:@"FOLDER"];
    }
    else {
        [cell setImageNamed:@"SampleThumb"];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Push viewcontroller for selected item
    // TODO: UX to redesign this completely as spec is missing
}

#pragma mark - UIScrollViewDelegate

static CGFloat scrollStart = kToggleCellHeight;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.collectionView]) {
        scrollStart = scrollView.contentOffset.y;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // TODO: Handle scroll behavior for any content that needs to hide
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate == NO) {
        [self scrollUpOrDownDetectToggleCell:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollUpOrDownDetectToggleCell:scrollView];
}

// This function calculates the magnetics for hiding the header of the collection view
- (void)scrollUpOrDownDetectToggleCell:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.collectionView]) {
        CGPoint scrollViewOffset = scrollView.contentOffset;
        
        CGRect navBarFrame = self.navigationController.navigationBar.frame;
        CGFloat contentOffsetDelta = navBarFrame.size.height + navBarFrame.origin.y;
        CGFloat actualScreenOffset = scrollViewOffset.y + contentOffsetDelta;
        
        // if we are offset scrolling up or offset scrolling down and
        // the cell is partially visible
        if ((actualScreenOffset < kToggleCellHeight) &&
            (actualScreenOffset > 0.f)) {
            
            if (actualScreenOffset > kToggleCellHeight/2.f) {
                // if we are more than half way down the toggle then scroll down
                scrollViewOffset.y = kToggleCellHeight - contentOffsetDelta;
            } else {
                // else if we are less than half way down the toggle then scroll up
                scrollViewOffset.y = 0.f - contentOffsetDelta;
            }
            
            [scrollView setContentOffset:scrollViewOffset  animated:YES];
        }
    }
}

#pragma mark - HTGridCollectionToggleCellDelegate

- (void)htGridCollectionToggleCell:(HTGridCollectionToggleCell *)cell willToggleToGrid:(BOOL)gridView
{
    // TODO: Handle toggle of cell layout
    // TODO: UX to redesign this completely as spec is missing
}

- (void)htGridCollectionToggleCell:(HTGridCollectionToggleCell *)cell didToggleToGrid:(BOOL)gridView
{
    // TODO: Handle toggle of cell layout
    // TODO: UX to redesign this completely as spec is missing
}

#pragma mark - HTGridCollectionToggleHeaderDelegate

- (void)htGridCollectionToggleHeader:(HTGridCollectionHeaderView *)cell willToggleToGrid:(BOOL)gridView
{
    
}

- (void)htGridCollectionToggleHeader:(HTGridCollectionHeaderView *)cell didToggleToGrid:(BOOL)gridView
{
    
}

@end
