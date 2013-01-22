//
//  NSDate+Calendar.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "NSDate+Calendar.h"
#import "NSCalendar+Calendar.h"

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

- (NSString*) monthName {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"LLLL"];
    return [formatter stringFromDate:self];
}

- (NSString*) yearShorthand {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy"];
    return [formatter stringFromDate:self];
}

- (NSDate*) firstDayOfMonth {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal calendarComponentsFromDate:self];
    [comps setDay:1];
    return [cal dateFromComponents:comps];
}

- (NSDate*) lastDayOfMonth {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal calendarComponentsFromDate:self];
    [comps setDay:[cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length];
    return [cal dateFromComponents:comps];
}

- (NSMutableArray*) datesInCurrentMonth;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSMutableArray *datesThisMonth = [NSMutableArray array];
    NSRange rangeOfDaysThisMonth = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    
    NSDateComponents *components = [calendar calendarComponentsFromDate:self];    
    for (NSInteger i = rangeOfDaysThisMonth.location; i < NSMaxRange(rangeOfDaysThisMonth); ++i) {
        [components setDay:i];
        NSDate *dayInMonth = [calendar dateFromComponents:components];
        [datesThisMonth addObject:dayInMonth];
    }
    return datesThisMonth;
}

- (NSArray*) datesInCalendarMonth
{    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar calendarComponentsFromDate:[self firstDayOfMonth]];
    
    //first days of week not including current month days
    NSMutableArray *firstWeekDays = [NSMutableArray array];
    for (int i = 1; i <= 7; i++) {
        [components setWeekday:i];
        NSDate *dayInWeek = [calendar dateFromComponents:components];
        if ([dayInWeek isSameDayAs:[self firstDayOfMonth]])
            break;
        [firstWeekDays addObject:dayInWeek];
    }

    //last days of week not including current month days
    components = [calendar calendarComponentsFromDate:[self lastDayOfMonth]];
    NSMutableArray *lastWeekDays = [NSMutableArray array];
    for (int i = [components weekday]+1; i <= 7; i++) {
        [components setWeekday:i];
        NSDate *dayInWeek = [calendar dateFromComponents:components];
        if ([dayInWeek isSameDayAs:[self firstDayOfMonth]])
            break;
        [lastWeekDays addObject:dayInWeek];
    }

    [firstWeekDays addObjectsFromArray:[self datesInCurrentMonth]];
    [firstWeekDays addObjectsFromArray:lastWeekDays];
    return firstWeekDays;
}

- (NSDate*) dateWithMonthOffset:(NSInteger)monthOffset {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setMonth:monthOffset];
    NSCalendar *cal = [NSCalendar currentCalendar];
    return [cal dateByAddingComponents:dateComp toDate:self options:0];;
}

- (NSDate*) nextMonth {
    return [self dateWithMonthOffset:1];
}
- (NSDate*) previousMonth {
    return [self dateWithMonthOffset:-1];
}

- (BOOL) isSameDayAs:(NSDate*)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *selfComp = [cal calendarComponentsFromDate:self];
    NSDateComponents *dateComp = [cal calendarComponentsFromDate:date];
    return [selfComp day]   == [dateComp day] &&
            [selfComp month] == [dateComp month] &&
            [selfComp year]  == [dateComp year];    
}

@end
