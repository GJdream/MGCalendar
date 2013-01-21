//
//  MGCalendarView.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "MGDayView.h"
#import "NSDate+Calendar.h"
#import "MGDotView.h"

@implementation MGDayView

@synthesize dateLabel = _dateLabel, dayLabel = _dayLabel, date = _date, dotView = _dotView;

- (UILabel*) dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.backgroundColor = [UIColor clearColor];
    }
    return _dateLabel;
}

- (UILabel*) dayLabel
{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] init];
        _dayLabel.backgroundColor = [UIColor clearColor];
    }
    return _dayLabel;
}

- (MGDotView*) dotView
{
    if (!_dotView) {
        _dotView = [[MGDotView alloc] init];
        _dotView.backgroundColor = [UIColor colorWithRed:0 green:0.5f blue:0 alpha:.5];
        _dotView.hidden = YES;
    }
    return _dotView;
}

- (void) setDefaults
{
    [self addSubview:self.dateLabel];
    [self addSubview:self.dayLabel];
    [self addSubview:self.dotView];
    
    self.dayLabel.text = [[self.date dayName] uppercaseString];
    self.dateLabel.text = [self.date dateNumber];
    
    [self.dateLabel sizeToFit];
    [self.dayLabel sizeToFit];
    
    //positions datelabel to top of screen
    NSInteger offset = 3;
    CGRect frame = self.frame;
    frame.size.height = self.dateLabel.frame.size.height;
    frame.origin = CGPointMake(offset, offset);
    frame.size.width = self.frame.size.width-offset;
    self.dateLabel.frame = frame;
    
    //position below the dayLabel
    frame.origin.y = frame.size.height-offset;
    frame.size.height = self.dayLabel.frame.size.height;
    self.dayLabel.frame = frame;
    
    //position dotView in bottom right of view
    frame.origin.y = self.dayLabel.frame.origin.y + self.dayLabel.frame.size.height;
    frame.size = self.dotView.frame.size;
    frame.origin.x = frame.size.width;
    self.dotView.frame = frame;
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

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self.delegate dayViewSelected:self];
}

@end
