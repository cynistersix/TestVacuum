//
//  HTCellActionItem.m
//  TestVacuum
//
//  Created by Daniel Biran on 5/9/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import "HTCellActionItem.h"

@implementation HTCellActionItem

- (id)initWithTitle:(NSString *)name andSelector:(SEL)selector andTarget:(id)target
{
    self = [super init];
    
    self.title = name;
    self.selector = selector;
    self.target = target;
    
    return self;
}

+ (id)cellActionItem:(NSString *)name withSelector:(SEL)selector andTarget:(id)target
{
    HTCellActionItem *retVal = [[HTCellActionItem alloc] initWithTitle:name andSelector:selector andTarget:target];
    
    return retVal;
}

- (void)performAction
{
    if ([self.target respondsToSelector:self.selector]) {
        IMP imp = [self.target methodForSelector:self.selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self.target, self.selector);;
    }
}

@end
