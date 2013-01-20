//
//  NSDate+Calendar.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)

- (NSString*) dayName
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE"];
    return [formatter stringFromDate:self];
}

- (NSString*) dateNumber
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    return [formatter stringFromDate:self];
}

- (NSArray*) datesInCurrentMonth;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSMutableArray *datesThisMonth = [NSMutableArray array];
    NSRange rangeOfDaysThisMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSEraCalendarUnit) fromDate:self];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    for (NSInteger i = rangeOfDaysThisMonth.location; i < NSMaxRange(rangeOfDaysThisMonth); ++i) {
        [components setDay:i];
        NSDate *dayInMonth = [calendar dateFromComponents:components];
        [datesThisMonth addObject:dayInMonth];
    }
    return datesThisMonth;
}

@end
