//
//  HTCellActionItem.h
//  TestVacuum
//
//  Created by Daniel Biran on 5/9/14.
//  Copyright (c) 2014 Hightail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTCellActionItem : NSObject

+ (id)cellActionItem:(NSString *)name withSelector:(SEL)selector andTarget:(id)target;

- (id)initWithTitle:(NSString *)name andSelector:(SEL)selector andTarget:(id)target;

- (void)performAction;

@property (nonatomic) NSString *title;
@property (nonatomic) SEL selector;
@property (nonatomic) id target;

@end
