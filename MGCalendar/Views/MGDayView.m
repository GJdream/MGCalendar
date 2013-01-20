//
//  MGCalendarView.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "MGDayView.h"
#import "MGLabel.h"
#import "NSDate+Calendar.h"

@implementation MGDayView

@synthesize dateLabel = _dateLabel, dayLabel = _dayLabel, date = _date;

- (MGLabel*) dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[MGLabel alloc] init];
        _dateLabel.fontSize = 15;
    }
    return _dateLabel;
}

- (MGLabel*) dayLabel
{
    if (!_dayLabel) {
        _dayLabel = [[MGLabel alloc] init];
        _dayLabel.fontSize = 10;
    }
    return _dayLabel;
}

- (void) setDefaults
{
    [self addSubview:self.dateLabel];
    [self addSubview:self.dayLabel];
    
    self.dayLabel.text = [[self.date dayName] uppercaseString];
    self.dateLabel.text = [self.date dateNumber];
    
    [self.dateLabel sizeToFit];
    [self.dayLabel sizeToFit];
    
    //positions datelabel to top of screen
    NSInteger offset = 3;
    CGRect frame = self.frame;
    frame.size.height = self.dateLabel.frame.size.height-offset;
    frame.origin = CGPointMake(offset, offset);
    frame.size.width = self.frame.size.width-offset;
    self.dateLabel.frame = frame;
    
    //position below the dateLabel
    frame.origin.y = frame.size.height+offset;
    frame.size.height = self.dayLabel.frame.size.height-offset;
    self.dayLabel.frame = frame;
}

- (id)initWithFrame:(CGRect)frame date:(NSDate*)date
{
    if (self = [super initWithFrame:frame]) {
        
        if (!date)
            return nil;
        
        _date = date;
        [self setDefaults];
    }
    return self;
}

@end
