//
//  MGCalendarView.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "MGCalendarView.h"
#import "NSDate+Calendar.h"

@interface MGCalendarView ()
@property (nonatomic) NSMutableArray *visibileDayViews;
@property (nonatomic) NSDate *currentDate;

@end

@implementation MGCalendarView

@synthesize monthLabel = _monthLabel, visibileDayViews = _visibileDayViews, currentDate = _currentDate;

- (NSDate*) currentDate {
    if (!_currentDate)
        _currentDate = [NSDate date];
    return _currentDate;
}

- (NSMutableArray*) visibileDayViews {
    if (!_visibileDayViews)
        _visibileDayViews = [[NSMutableArray alloc] init];
    return _visibileDayViews;
}

- (UILabel*) monthLabel
{
    if (!_monthLabel) {
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, [self sizeOfDayView].height);
        _monthLabel = [[UILabel alloc] initWithFrame:frame];
        _monthLabel.backgroundColor = [UIColor clearColor];
        _monthLabel.textAlignment = UITextAlignmentCenter;
        _monthLabel.font = [UIFont systemFontOfSize:30.0f];
        _monthLabel.text = [self.currentDate monthName];
    }
    return _monthLabel;
}

- (CATransition*) transitionAnimation {
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.duration = .2f;
    return transition;
}

- (id) init {
    return [self initWithPadding:1];
}

- (id) initWithPadding:(NSUInteger)padding
{
    if (self = [super init]) {
        NSInteger height = 325;
        height *= (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 2.1: 1;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
        _padding = padding;
        
        [self addSubview:self.monthLabel];
        
        //set defaults
        self.dayViewBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.dayViewTextColor = [UIColor blackColor];
        self.dayViewDateFont = [UIFont systemFontOfSize:15];
        self.dayViewDayFont = [UIFont systemFontOfSize:10];
        self.dayViewBorderColor = [UIColor whiteColor];
        self.dayViewBorderWidth = .5f;
        
        self.currentDayViewBackgroundColor = [UIColor colorWithRed:0 green:1.0f blue:0 alpha:1];
        
        self.selectedDayViewBackgroundColor = [UIColor colorWithRed:0.5 green:0 blue:0.0 alpha:.5];
        self.selectedDayViewTextColor = [UIColor whiteColor];
        self.selectedDayViewBorderColor = [UIColor whiteColor];
        self.selectedDayViewBorderWidth = .5f;
        
        UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightGestureDetected:)];
        swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeGesture];
        
        swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftGestureDetected:)];
        swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeGesture];

        
        [self resetCalendar];
    }
    return self;
}

- (void) reloadData {
    [self removeVisibileDayViews];
    [self resetCalendar];
}

- (CGSize) sizeOfDayView
{
    //7 = days in a week
    CGFloat width = (self.frame.size.width / 7.0f) - (self.padding);
    CGFloat height = (self.frame.size.height / 6.0f) - (self.padding);
    return CGSizeMake(width, height);
}

- (void) removeVisibileDayViews {
    for (MGDayView *dayView in self.visibileDayViews) {
        [dayView removeFromSuperview];
    }
    [self.visibileDayViews removeAllObjects];
}

- (void) resetCalendar
{
    NSArray *dates = [self.currentDate datesInCurrentMonth];
    int row = 0;
    int col = 0;
    for (NSDate *date in dates) {
        CGRect frame;
        frame.size = [self sizeOfDayView];
        frame.origin.x = col*frame.size.width + self.padding*col + self.padding*.5;
        frame.origin.y = row*frame.size.height + self.padding*row + self.monthLabel.frame.size.height;
        MGDayView *dayView = [[MGDayView alloc] initWithFrame:frame date:date];
        dayView.delegate = self;
        [self addSubview:dayView];
        [self.visibileDayViews addObject:dayView];
        
        //restore defaults
        dayView.backgroundColor = self.dayViewBackgroundColor;
        dayView.dateLabel.textColor = self.dayViewTextColor;
        dayView.dayLabel.textColor = self.dayViewTextColor;
        dayView.dateLabel.font = self.dayViewDateFont;
        dayView.dayLabel.font = self.dayViewDayFont;
        dayView.layer.borderColor = self.dayViewBorderColor.CGColor;
        dayView.layer.borderWidth = self.dayViewBorderWidth;

        col++;
        if (col == 7) {
            col = 0;
            row++;
        }
        
    }
    _monthLabel.text = [self.currentDate monthName];
}

- (void) setCurrentDate:(NSDate *)currentDate {
    _currentDate = currentDate;
    [self reloadData];
}

#pragma mark - UIGesture methods
- (void) swipeRightGestureDetected:(UISwipeGestureRecognizer*)gesture {
    CATransition *transition = [self transitionAnimation];
    transition.subtype = kCATransitionFromLeft;
    [self.layer addAnimation:transition forKey:@"Transition"];
    self.currentDate = [self.currentDate previousMonth];
}

- (void) swipeLeftGestureDetected:(UISwipeGestureRecognizer*)gesture {
    CATransition *transition = [self transitionAnimation];
    transition.subtype = kCATransitionFromRight;
    [self.layer addAnimation:transition forKey:@"Transition"];
    self.currentDate = [self.currentDate nextMonth];
}

#pragma mark - Setting DayView Values
- (void) setDayViewKey:(NSString*)key value:(id)value
{
    BOOL isKeyPath = ([key rangeOfString:@"."].location != NSNotFound);
    for (MGDayView *dayView in self.visibileDayViews) {
        if (isKeyPath)
            [dayView setValue:value forKeyPath:key];
        else
            [dayView setValue:value forKey:key];
    }
    
}

- (void) setDayViewBackgroundColor:(UIColor *)dayViewBackgroundColor {
    [self setDayViewKey:@"backgroundColor" value:dayViewBackgroundColor];
    _dayViewBackgroundColor = dayViewBackgroundColor;
}

- (void) setDayViewBorderColor:(UIColor *)dayViewBorderColor {
    [self setDayViewKey:@"layer.borderColor" value:(id)dayViewBorderColor.CGColor];
    _dayViewBorderColor = dayViewBorderColor;
}

- (void) setDayViewBorderWidth:(CGFloat)dayViewBorderWidth {
    [self setDayViewKey:@"layer.borderWidth" value:[NSNumber numberWithFloat:dayViewBorderWidth]];
    _dayViewBorderWidth = dayViewBorderWidth;
}

- (void) setDayViewDayFont:(UIFont *)dayViewDayFont {
    [self setDayViewKey:@"dayLabel.font" value:dayViewDayFont];
    _dayViewDayFont = dayViewDayFont;
}

- (void) setDayViewDateFont:(UIFont *)dayViewDateFont {
    [self setDayViewKey:@"dateLabel.font" value:dayViewDateFont];
    _dayViewDateFont = dayViewDateFont;
}

- (void) setDayViewTextColor:(UIColor *)dayViewTextColor {
    [self setDayViewKey:@"dayLabel.textColor" value:dayViewTextColor];
    [self setDayViewKey:@"dateLabel.textColor" value:dayViewTextColor];
    _dayViewTextColor = dayViewTextColor;
}

#pragma mark - MGDayViewDelegate method
- (void) dayViewSelected:(MGDayView *)dayView
{
    //reset values
    [_selectedDayView setBackgroundColor:self.dayViewBackgroundColor];
    _selectedDayView.dayLabel.textColor = self.dayViewTextColor;
    _selectedDayView.dateLabel.textColor = self.dayViewTextColor;
    _selectedDayView.layer.borderColor = self.dayViewBorderColor.CGColor;
    _selectedDayView.layer.borderWidth = self.dayViewBorderWidth;

    //set new values
    _selectedDayView = dayView;
    _selectedDayView.backgroundColor = self.selectedDayViewBackgroundColor;
    _selectedDayView.dayLabel.textColor = self.selectedDayViewTextColor;
    _selectedDayView.dateLabel.textColor = self.selectedDayViewTextColor;
    _selectedDayView.layer.borderColor = self.selectedDayViewBorderColor.CGColor;
    _selectedDayView.layer.borderWidth = self.selectedDayViewBorderWidth;
}

@end
