//
//  HTGridCollectionViewCell.h
//  TestVacuum
//
//  Created by Daniel Biran on 5/19/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTGridCollectionViewCell : UICollectionViewCell

- (void)setDefaultFileType:(NSString *)fileType;
- (void)setImagePath:(NSString *)path;
- (void)setImageNamed:(NSString *)imageName;

@property (nonatomic, retain) IBOutlet UILabel *cellNum;
@property (nonatomic, retain) IBOutlet UILabel *title;
@property (nonatomic, retain) IBOutlet UILabel *details;

@end
