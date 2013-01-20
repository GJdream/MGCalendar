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
    self.layer.cornerRadius = 25;
}

- (id) init
{
    if (self = [super init]) {
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
