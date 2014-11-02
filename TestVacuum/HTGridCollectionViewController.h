//
//  HTGridCollectionViewController.h
//  TestVacuum
//
//  Created by Daniel Biran on 5/19/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTGridCollectionToggleCell.h"

@interface HTGridCollectionViewController : UIViewController <UICollectionViewDelegate,
                                                              UICollectionViewDataSource,
                                                              UICollectionViewDelegateFlowLayout,
                                                              HTGridCollectionToggleCellDelegate>

@end
