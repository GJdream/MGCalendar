//
//  DemoControl.m
//  Demo
//
//  Created by Mark Glagola on 1/21/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "DemoControl.h"

@implementation DemoControl

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.alpha = highlighted ? .5f : 1.0f;
}

@end
