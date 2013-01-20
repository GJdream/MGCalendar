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

@interface MGCalendarView : UIView <MGDayViewDelegate> {
    NSMutableArray *visibileDayViews;
}

//only set on init
@property (nonatomic, readonly) NSUInteger padding;

@property (nonatomic) UIColor *dayViewBorderColor;
@property (nonatomic) CGFloat dayViewBorderWidth;
@property (nonatomic) UIColor *dayViewBackgroundColor;
@property (nonatomic) UIFont *dayViewDateFont;
@property (nonatomic) UIFont *dayViewDayFont;
@property (nonatomic) UIColor *dayViewTextColor;

@property (nonatomic) UIColor *currentDayViewBackgroundColor;

@property (nonatomic, readonly) MGDayView *selectedDayView;
@property (nonatomic) UIColor *selectedDayViewBackgroundColor;
@property (nonatomic) UIColor *selectedDayViewTextColor;

//optional
//could just use init (Default padding = 1)
- (id) initWithPadding:(NSUInteger)padding;

@end
