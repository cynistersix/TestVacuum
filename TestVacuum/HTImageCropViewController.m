//
//  HTImageCropViewController.m
//  TestVacuum
//
//  Created by Daniel Biran on 11/24/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTImageCropViewController.h"
#import "HTCropView.h"

@interface HTImageCropViewController ()

@property (nonatomic, weak) IBOutlet HTCropView *cropWindow;

@end

@implementation HTImageCropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

@end
