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

@implementation MGCalendarView

- (void) setDayViewKey:(NSString*)key value:(id)value
{
    BOOL isKeyPath = ([key rangeOfString:@"."].location != NSNotFound);
    for (MGDayView *dayView in visibileDayViews) {
        if (isKeyPath)
            [dayView setValue:value forKeyPath:key];
        else
            [dayView setValue:value forKey:key];
    }
    
}

- (void) setDayViewBorderBackgroundColor:(UIColor *)dayViewBorderBackgroundColor {
    [self setDayViewKey:@"backgroundColor" value:dayViewBorderBackgroundColor];
    _dayViewBorderBackgroundColor = dayViewBorderBackgroundColor;
}

- (void) setDayViewBorderColor:(UIColor *)dayViewBorderColor {
    [self setDayViewKey:@"layer.borderColor" value:(id)dayViewBorderColor.CGColor];
    _dayViewBorderColor = dayViewBorderColor;
}

- (void) setDayViewBorderWidth:(CGFloat)dayViewBorderWidth {
    [self setDayViewKey:@"layer.borderWidth" value:[NSNumber numberWithFloat:dayViewBorderWidth]];
    _dayViewBorderWidth = dayViewBorderWidth;
}

- (void) setDayViewDayFont:(UIFont *)dayViewDayFont {
    [self setDayViewKey:@"dayLabel.font" value:dayViewDayFont];
    _dayViewDayFont = dayViewDayFont;
}

- (void) setDayViewDateFont:(UIFont *)dayViewDateFont {
    [self setDayViewKey:@"dateLabel.font" value:dayViewDateFont];
    _dayViewDateFont = dayViewDateFont;
}

- (CGSize) sizeOfDayView
{
    //7 = days in a week
    //6 = max # of rows in a calendar
    CGFloat width = (self.frame.size.width / 7.0f) - (self.padding);
    CGFloat height = (self.frame.size.height / 6.0f) - (self.padding);
    return CGSizeMake(width, height);
}

- (void) resetCalendar
{
    NSArray *dates = [[NSDate date] datesInCurrentMonth];
    visibileDayViews = [[NSMutableArray alloc] init];
    
    int row = 0;
    int col = 0;
    for (NSDate *date in dates) {
        CGRect frame;
        frame.size = [self sizeOfDayView];
        frame.origin = CGPointMake(col*frame.size.width + self.padding*col + self.padding*.5, row*frame.size.height + self.padding*row);
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

- (id) init {
    return [self initWithPadding:1];
}

- (id) initWithPadding:(NSUInteger)padding
{
    if (self = [super init]) {
        NSInteger height = 325;
        height *= (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 2.1: 1;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
        _padding = padding;
        [self resetCalendar];
    }
    return self;
}

@end
