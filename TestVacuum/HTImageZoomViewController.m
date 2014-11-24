//
//  HTImageZoomViewController.m
//  TestVacuum
//
//  Created by Daniel Biran on 11/17/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTImageZoomViewController.h"
#import "HTZoomScrollView.h"

@interface HTImageZoomViewController ()

- (IBAction)gestureRecognizerTwoTaps:(UIGestureRecognizer *)recognizer;
- (IBAction)gestureRecognizerPinchZoom:(UIGestureRecognizer *)recognizer;

@property (nonatomic, weak) IBOutlet HTZoomScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

NSString * const kImageName = @"002-bentley-continental-gt3.jpg";

@implementation HTImageZoomViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view from its nib.
    
//    self.view = [[[NSBundle mainBundle] loadNibNamed:@"HTImageZoomViewController" owner:self options:nil] objectAtIndex:0];
    
    self.imageView.image = [UIImage imageNamed:kImageName];
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageView.image.size.width, self.imageView.image.size.height);
//    self.scrollView.contentSize = self.imageView.image.size;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s - %@", __PRETTY_FUNCTION__, NSStringFromCGRect(self.view.frame));

    // set the frame size since the xib doesn't resize for you
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self setupScales];
}

#pragma mark - UIGestureRecognizer Handlers

#pragma mark -
#pragma mark - ScrollView Delegate methods

// keep the view from decellerating the scrolls
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [scrollView setContentOffset:scrollView.contentOffset animated:YES];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIView *subView = self.imageView;
    
    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
    
    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                 scrollView.contentSize.height * 0.5 + offsetY);
}

#pragma mark -
#pragma mark - ScrollView gesture methods


- (IBAction)gestureRecognizerTwoTaps:(UIGestureRecognizer *)recognizer {
    // Get the location within the image view where we tapped
    CGPoint pointInView = [recognizer locationInView:self.imageView];
    
    // Get a zoom scale that's zoomed in slightly, capped at the maximum zoom scale specified by the scroll view
    CGFloat newZoomScale = self.scrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, self.scrollView.maximumZoomScale);
    
    // Figure out the rect we want to zoom to, then zoom to it
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [self.scrollView zoomToRect:rectToZoomTo animated:YES];
}

- (IBAction)gestureRecognizerPinchZoom:(UIGestureRecognizer *)recognizer {
    
}

#pragma mark - Zooming

- (void)centerScrollViewContents {
    // This method centers the scroll view contents also used on did zoom
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}

-(void)setupScales {
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 2.0f;
    self.scrollView.zoomScale = minScale;
    
    // re-adjust the contentsize since zooming changed it to an incorrect value
//    self.scrollView.contentSize = CGSizeMake(MAX(self.imageView.image.size.width*minScale, self.scrollView.frame.size.width), MAX(self.imageView.image.size.height*minScale, self.scrollView.frame.size.height));
    [self centerScrollViewContents];
}

@end
