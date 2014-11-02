//
//  HTGridCollectionViewCell.m
//  TestVacuum
//
//  Created by Daniel Biran on 5/19/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTGridCollectionViewCell.h"
#import "HTGridCollectionImageView.h"

@interface HTGridCollectionViewCell ()

@property (nonatomic, retain) IBOutlet HTGridCollectionImageView *htImageView;

@end

@implementation HTGridCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"HTGridCollectionViewCell" owner:self options:nil];
        
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

- (void)setDefaultFileType:(NSString *)fileType
{
    // MOB-5223: Default file icon handling
    // there is already code in the main project to get the image in a utility class
    self.htImageView.defaultIcon.image = [UIImage imageNamed:@"FolderIcon"];
}

- (void)setImagePath:(NSString *)path
{
    self.htImageView.thumbImageView.image = [UIImage imageWithContentsOfFile:path];
}

- (void)setImageNamed:(NSString *)imageName
{
    self.htImageView.thumbImageView.image = [UIImage imageNamed:imageName];
}

@end
