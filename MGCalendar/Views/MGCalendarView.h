//
//  MGCalendarView.h
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MGDayView.h"

@protocol MGCalendarViewDelegate <NSObject>
@optional
- (NSArray*) calendarMarkedDates;
- (void) calendarSelectedDate:(NSDate*)date;
- (void) calendarBaseDateUpdated:(NSDate*)date;
@end

@interface MGCalendarView : UIView <MGDayViewDelegate>

@property (nonatomic) id<MGCalendarViewDelegate> delegate;

//The current date the calendar is based on
//baseDate is offsetted from [NSDate date]
//i.e. if its the 3rd of jan, next month is the 3rd of feb
//Better to use ANIMATED month methods (bottom of .h) then to set directly
//When set, reloadData is called automatically
@property (nonatomic) NSDate *baseDate;

//only set on init
@property (nonatomic, readonly) NSUInteger padding;

//default is YES
//responsibile for swiping between months
@property (nonatomic) BOOL isSwipeGestureEnabled;

@property (nonatomic) UIColor *dayViewBorderColor;
@property (nonatomic) CGFloat dayViewBorderWidth;
@property (nonatomic) UIColor *dayViewBackgroundColor;
@property (nonatomic) UIFont *dayViewDateFont;
@property (nonatomic) UIFont *dayViewDayFont;
@property (nonatomic) UIColor *dayViewTextColor;
@property (nonatomic) UIColor *dayViewDotColor;

@property (nonatomic) NSString *defaultFontName;

//-will need to call reloadData after setting theses values-//
@property (nonatomic) UIColor *differentMonthDayViewBackgroundColor;
@property (nonatomic) UIColor *differentMonthDayViewBorderColor;
@property (nonatomic) UIColor *differentMonthDayViewTextColor;

@property (nonatomic) UIColor *currentDayViewBackgroundColor;
@property (nonatomic) UIColor *currentDayViewBorderColor;
@property (nonatomic) UIColor *currentDayViewTextColor;

@property (nonatomic, readonly) MGDayView *selectedDayView;
@property (nonatomic) UIColor *selectedDayViewBackgroundColor;
@property (nonatomic) UIColor *selectedDayViewTextColor;
@property (nonatomic) UIColor *selectedDayViewBorderColor;
//---------------------------------------------------------//

//optional
//could just use init (Default padding = 5)
- (id) initWithPadding:(NSUInteger)padding;
- (id) initWithPadding:(NSUInteger)padding width:(CGFloat)width;

- (void) reloadData;

- (void) nextMonthAnimated:(BOOL)animated;
- (void) previousMonthAnimated:(BOOL)animated;
- (void) resetToCurrentMonthAnimated:(BOOL)animated;

@end
