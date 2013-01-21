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
@end

@interface MGCalendarView : UIView <MGDayViewDelegate>

@property (nonatomic) id<MGCalendarViewDelegate> delegate;

//only set on init
@property (nonatomic, readonly) NSUInteger padding;

@property (nonatomic, readonly) UILabel *monthLabel;
@property (nonatomic, readonly) UILabel *yearLabel;

@property (nonatomic) UIColor *dayViewBorderColor;
@property (nonatomic) CGFloat dayViewBorderWidth;
@property (nonatomic) UIColor *dayViewBackgroundColor;
@property (nonatomic) UIFont *dayViewDateFont;
@property (nonatomic) UIFont *dayViewDayFont;
@property (nonatomic) UIColor *dayViewTextColor;
@property (nonatomic) UIColor *dayViewDotColor;

//-will need to call reloadData after setting theses values-//
@property (nonatomic) UIColor *currentDayViewBackgroundColor;
@property (nonatomic) UIColor *currentDayViewBorderColor;
@property (nonatomic) UIColor *currentDayViewTextColor;
//---------------------------------------------------------//

@property (nonatomic, readonly) MGDayView *selectedDayView;
//-will need to call reloadData after setting theses values-//
@property (nonatomic) UIColor *selectedDayViewBackgroundColor;
@property (nonatomic) UIColor *selectedDayViewTextColor;
@property (nonatomic) UIColor *selectedDayViewBorderColor;
//---------------------------------------------------------//

//optional
//could just use init (Default padding = 5)
- (id) initWithPadding:(NSUInteger)padding;

- (void) reloadData;

@end
