//
//  MGDotView.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "MGDotView.h"

@implementation MGDotView

- (void) setDefaults {
    self.layer.cornerRadius = self.frame.size.width * .5f;
}

- (id) init
{
    if (self = [super init]) {
        NSInteger size = 5;
        self.frame = CGRectMake(0, 0, size, size);
        [self setDefaults];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setDefaults];
    }
    return self;
}

@end
