//
//  MGCalendarView.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "MGCalendarView.h"
#import "NSDate+Calendar.h"

@implementation MGCalendarView

@synthesize monthLabel = _monthLabel;

- (UILabel*) monthLabel
{
    if (!_monthLabel) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/6.0f - self.padding);
        _monthLabel = [[UILabel alloc] initWithFrame:frame];
        _monthLabel.backgroundColor = [UIColor clearColor];
        _monthLabel.textAlignment = UITextAlignmentCenter;
        _monthLabel.font = [UIFont systemFontOfSize:24.0f];
        _monthLabel.text = [currentDate monthName];
        [_monthLabel sizeToFit];
        frame.size.width = self.frame.size.width;
        _monthLabel.frame = frame;
    }
    return _monthLabel;
}

#pragma mark - Setting DayView Values
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

- (void) setDayViewBackgroundColor:(UIColor *)dayViewBackgroundColor {
    [self setDayViewKey:@"backgroundColor" value:dayViewBackgroundColor];
    _dayViewBackgroundColor = dayViewBackgroundColor;
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

- (void) setDayViewTextColor:(UIColor *)dayViewTextColor {
    [self setDayViewKey:@"dayLabel.textColor" value:dayViewTextColor];
    [self setDayViewKey:@"dateLabel.textColor" value:dayViewTextColor];
    _dayViewTextColor = dayViewTextColor;
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
        frame.origin.x = col*frame.size.width + self.padding*col + self.padding*.5;
        frame.origin.y = row*frame.size.height + self.padding*row + self.monthLabel.frame.size.height;
        MGDayView *dayView = [[MGDayView alloc] initWithFrame:frame date:date];
        dayView.delegate = self;
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
        
        currentDate = [NSDate date];
        [self addSubview:self.monthLabel];
        
        [self resetCalendar];
        
        //set defaults
        self.dayViewBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.dayViewTextColor = [UIColor blackColor];
        self.dayViewDateFont = [UIFont systemFontOfSize:15];
        self.dayViewDayFont = [UIFont systemFontOfSize:10];
        self.dayViewBorderColor = [UIColor whiteColor];
        self.dayViewBorderWidth = .5f;

        self.currentDayViewBackgroundColor = [UIColor colorWithRed:0 green:1.0f blue:0 alpha:1];

        self.selectedDayViewBackgroundColor = [UIColor colorWithRed:0.5 green:0 blue:0.0 alpha:.5];
        self.selectedDayViewTextColor = [UIColor whiteColor];
        self.selectedDayViewBorderColor = [UIColor whiteColor];
        self.selectedDayViewBorderWidth = .5f;
    }
    return self;
}

#pragma mark - MGDayViewDelegate method
- (void) dayViewSelected:(MGDayView *)dayView
{
    //reset values
    [_selectedDayView setBackgroundColor:self.dayViewBackgroundColor];
    _selectedDayView.dayLabel.textColor = self.dayViewTextColor;
    _selectedDayView.dateLabel.textColor = self.dayViewTextColor;
    _selectedDayView.layer.borderColor = self.dayViewBorderColor.CGColor;
    _selectedDayView.layer.borderWidth = self.dayViewBorderWidth;

    //set new values
    _selectedDayView = dayView;
    _selectedDayView.backgroundColor = self.selectedDayViewBackgroundColor;
    _selectedDayView.dayLabel.textColor = self.selectedDayViewTextColor;
    _selectedDayView.dateLabel.textColor = self.selectedDayViewTextColor;
    _selectedDayView.layer.borderColor = self.selectedDayViewBorderColor.CGColor;
    _selectedDayView.layer.borderWidth = self.selectedDayViewBorderWidth;
}

@end
