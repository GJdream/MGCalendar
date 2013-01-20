//
//  MGCalendarView.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "MGCalendarView.h"
#import "MGDayView.h"
#import "NSDate+Calendar.h"

//the padding in between DayViews (vertical & horizontal)
static NSInteger const kMGDayViewPadding = 1;

@implementation MGCalendarView

- (CGSize) sizeOfDayView
{
    //7 = days in a week
    //6 = max # of rows in a calendar
    CGFloat width = (self.frame.size.width / 7.0f);
    CGFloat height = (self.frame.size.height / 6.0f);
    return CGSizeMake(width, height);
}

- (void) setDefaults
{
    NSArray *dates = [[NSDate date] datesInCurrentMonth];
    visibileDayViews = [[NSMutableArray alloc] init];
    
    int row = 0;
    int col = 0;
    for (NSDate *date in dates) {
        CGRect frame;
        frame.size = [self sizeOfDayView];
        frame.origin = CGPointMake(col*frame.size.width + kMGDayViewPadding*col, row*frame.size.height + kMGDayViewPadding*row);
        MGDayView *dayView = [[MGDayView alloc] initWithFrame:frame date:date];
        [self addSubview:dayView];
        [visibileDayViews addObject:dayView];
        
        col++;
        if (col == 7) {
            col = 0;
            row++;
        }

    }
    
    
}

- (id) init
{
    if (self = [super init]) {
        
        NSInteger offSet = 10;
        self.frame = CGRectMake(offSet*.5f, 0, [UIScreen mainScreen].bounds.size.width-offSet, 400);
        [self setDefaults];
    }
    return self;
}

@end
