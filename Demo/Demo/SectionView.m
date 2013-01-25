//
//  SectionView.m
//  Demo
//
//  Created by Mark Glagola on 1/24/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "SectionView.h"

@implementation SectionView

- (void) awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture-gray"]];
    self.layer.shadowOffset = CGSizeMake(0, -3);
    self.layer.shadowOpacity = .5f;
}

@end
