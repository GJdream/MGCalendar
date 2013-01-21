//
//  NSDate+Calendar.h
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

- (NSString*) dayName;
- (NSString*) dateNumber;
- (NSString*) monthName;
- (NSString*) yearShorthand;

- (NSArray*) datesInCurrentMonth;

- (NSDate*) nextMonth;
- (NSDate*) previousMonth;

@end
