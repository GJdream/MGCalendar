//
//  MGCalendarView.h
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGDotView, MGLabel, MGDayView;

@protocol MGDayViewDelegate <NSObject>
- (void) dayViewSelected:(MGDayView*)dayView;
@end

@interface MGDayView : UIControl

@property (nonatomic) id<MGDayViewDelegate>delegate;

@property (nonatomic, readonly) NSDate *date;
@property (nonatomic, readonly) MGLabel *dateLabel;
@property (nonatomic, readonly) MGLabel *dayLabel;

- (id)initWithFrame:(CGRect)frame date:(NSDate*)date;

@end
