//
//  NSDate+Calendar.h
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

- (NSString*) stringFromDateWithFormat:(NSString*)format;

- (NSString*) dayName;
- (NSString*) dateNumber;
- (NSString*) monthName;

- (NSDate*) firstDayOfMonth;
- (NSDate*) lastDayOfMonth;

- (NSMutableArray*) lastDatesInPreviousMonth;
- (NSMutableArray*) datesInCurrentMonth;
- (NSMutableArray*) firstDatesInNextMonth;

//Combines lastDatesInPreviousMonth + datesInCurrentMonth + firstDatesInNextMonth
//This makes the calendar as you know it
- (NSMutableArray*) datesInCalendarMonth; 

- (NSDate*) nextMonth;
- (NSDate*) previousMonth;

- (BOOL) isSameDayAs:(NSDate*)date;
- (BOOL) isSameMonthAs:(NSDate*)date;

@end
