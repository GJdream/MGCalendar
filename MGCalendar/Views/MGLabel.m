//
//  MGLabel.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "MGLabel.h"

@implementation MGLabel

- (void) setDefaults {
    self.backgroundColor = [UIColor clearColor];
    self.minimumFontSize = 8;
    _fontSize = 12;
    self.font = [UIFont fontWithName:@"HelveticaNeue" size:self.fontSize];
}

- (void) setFontSize:(CGFloat)fontSize
{
    self.font = [UIFont fontWithName:self.font.fontName size:fontSize];
    _fontSize = fontSize;
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
