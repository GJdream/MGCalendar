//
//  NSDateComponents+Calendar.m
//  Demo
//
//  Created by Mark Glagola on 1/21/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "NSCalendar+Calendar.h"

@implementation NSCalendar (Calendar)

NSUInteger defaultComponents() {
    return (NSYearForWeekOfYearCalendarUnit |NSYearCalendarUnit | NSMonthCalendarUnit |
            NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSEraCalendarUnit);
}

- (NSDateComponents*) calendarComponentsFromDate:(NSDate*)date
{
    NSDateComponents *components = [self components:defaultComponents() fromDate:date];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return components;
}

@end
