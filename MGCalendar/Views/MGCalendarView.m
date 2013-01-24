//
//  MGCalendarView.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "MGCalendarView.h"
#import "NSDate+Calendar.h"
#import "MGDotView.h"
#import "NSCalendar+Calendar.h"

@interface MGCalendarView () {
    MGDayView *currentDayView;
}

@property (nonatomic) NSMutableArray *visibileDayViews;

@end

@implementation MGCalendarView

@synthesize visibileDayViews = _visibileDayViews, baseDate = _baseDate;

int iPadModefier() {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 2.1 : 1;
}

- (NSDate*) baseDate {
    if (!_baseDate)
        _baseDate = [NSDate date];
    return _baseDate;
}

- (NSMutableArray*) visibileDayViews {
    if (!_visibileDayViews)
        _visibileDayViews = [[NSMutableArray alloc] init];
    return _visibileDayViews;
}

- (CATransition*) transitionAnimation {
    CATransition *transition = [CATransition animation];
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.duration = .2f;
    transition.type = kCATransitionPush;
    return transition;
}

- (id) init {
    return [self initWithPadding:5];
}

- (id) initWithPadding:(NSUInteger)padding {
    return [self initWithPadding:padding width:[UIScreen mainScreen].bounds.size.width];
}

- (id) initWithPadding:(NSUInteger)padding width:(CGFloat)width {
    if (self = [super init]) {
        _padding = padding * iPadModefier();
        NSInteger height = ([self sizeOfDayView].height + self.padding) * 6.0f;
        self.frame = CGRectMake(0, 0, width, height);
        _isSwipeGestureEnabled = YES;
        
        //set defaults
        self.dayViewBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        self.dayViewTextColor = [UIColor blackColor];
        self.dayViewDateFont = [UIFont systemFontOfSize:15];
        self.dayViewDayFont = [UIFont systemFontOfSize:10];
        self.dayViewBorderColor = [UIColor whiteColor];
        self.dayViewDotColor = [UIColor colorWithRed:0.0 green:0.5 blue:0 alpha:.5];
        self.dayViewBorderWidth = .5f;
        
        self.differentMonthDayViewBackgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        self.differentMonthDayViewBorderColor = [UIColor colorWithWhite:0.95 alpha:1];
        self.differentMonthDayViewTextColor = [UIColor lightGrayColor];
        
        self.selectedDayViewBackgroundColor = [UIColor colorWithRed:0 green:.5 blue:0.0 alpha:.35];
        self.selectedDayViewTextColor = [UIColor whiteColor];
        self.selectedDayViewBorderColor = [UIColor whiteColor];
        
        self.currentDayViewBackgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.5 alpha:.5];
        self.currentDayViewBorderColor = [UIColor blueColor];
        self.currentDayViewTextColor = self.selectedDayViewBorderColor;
        
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


- (void) nextMonthAnimated:(BOOL)animated {
    if (animated) {
        CATransition *transition = [self transitionAnimation];
        transition.subtype = kCATransitionFromRight;
        [self.layer addAnimation:transition forKey:@"TransitionFromRight"];
    }
    self.baseDate = [self.baseDate nextMonth];
}

- (void) previousMonthAnimated:(BOOL)animated {
    if (animated) {
        CATransition *transition = [self transitionAnimation];
        transition.subtype = kCATransitionFromLeft;
        [self.layer addAnimation:transition forKey:@"TransitionFromLeft"];
    }
    self.baseDate = [self.baseDate previousMonth];
}

- (void) resetToCurrentMonthAnimated:(BOOL)animated {
    self.baseDate = [NSDate date];
}

//gets dayview associated with day of date
- (MGDayView*) dayViewForDate:(NSDate*)date {
    if ([date isSameMonthAs:self.baseDate]) {
        NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
        NSInteger day = [comps day] + [date lastDatesInPreviousMonth].count-1; //add to prevous dates if any
        if (day < self.visibileDayViews.count)
            return [self.visibileDayViews objectAtIndex:day];
    }
    
    return nil;
}

#pragma mark - Recalculating View methods
- (void) reloadData {
    [self removeVisibileDayViews];
    [self resetCalendar];
}

- (CGSize) sizeOfDayView
{
    //7 = days in a week
    CGFloat width = (self.frame.size.width / 7.0f) - (self.padding);
    CGFloat height = (54 * iPadModefier()) - self.padding;
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
    NSArray *dates = [self.baseDate datesInCalendarMonth];
    int row = 0;
    int col = 0;
    for (NSDate *date in dates) {
        CGRect frame;
        frame.size = [self sizeOfDayView];
        frame.origin.x = col*frame.size.width + self.padding*col + self.padding*.5;
        frame.origin.y = row*frame.size.height + self.padding*row + self.padding*.5;
        MGDayView *dayView = [[MGDayView alloc] initWithFrame:frame date:date];
        dayView.delegate = self;
        [self addSubview:dayView];
        [self.visibileDayViews addObject:dayView];
    
        //reset defaults
        [self resetValuesForDayView:dayView];

        //set dotView to hide/unhide depending on calendarMarkedDates from delegate
        BOOL doesNotContainMarkedDate = YES;
        for (NSDate *markedDate in [self.delegate calendarMarkedDates]) {
            if ([markedDate isSameDayAs:date]) {
                doesNotContainMarkedDate = NO;
            }
        }
        dayView.dotView.hidden = doesNotContainMarkedDate;
        
        //update for frame positioning
        col++;
        if (col == 7) {
            col = 0;
            row++;
        }
        
    }
    
    if ([self.delegate respondsToSelector:@selector(calendarBaseDateUpdated:)])
        [self.delegate calendarBaseDateUpdated:self.baseDate];
    
    //resets selected view
    [self dayViewSelected:nil];
}

- (void) resetValuesForDayView:(MGDayView*)dayView
{
    BOOL isToday = [dayView.date isSameDayAs:[NSDate date]];
    if (isToday) currentDayView = dayView;
    dayView.backgroundColor = isToday ? self.currentDayViewBackgroundColor : self.dayViewBackgroundColor;
    dayView.dateLabel.textColor = isToday ? self.currentDayViewTextColor : self.dayViewTextColor;
    dayView.dayLabel.textColor = isToday ? self.currentDayViewTextColor : self.dayViewTextColor;
    dayView.layer.borderColor = isToday ? self.currentDayViewBorderColor.CGColor : self.dayViewBorderColor.CGColor;
    dayView.layer.borderWidth = self.dayViewBorderWidth;
    dayView.dateLabel.font = self.dayViewDateFont;
    dayView.dayLabel.font = self.dayViewDayFont;
    dayView.dotView.backgroundColor = self.dayViewDotColor;
    
    //not the same month (either last months last week dates or next months first week days)
    if (dayView.date && ![self.baseDate isSameMonthAs:dayView.date]) {
        dayView.backgroundColor = self.differentMonthDayViewBackgroundColor;
        dayView.dateLabel.textColor = self.differentMonthDayViewTextColor;
        dayView.dayLabel.textColor = self.differentMonthDayViewTextColor;
        dayView.layer.borderColor = self.differentMonthDayViewBorderColor.CGColor;
    }
    
}

#pragma mark - MGDayViewDelegate method
- (void) dayViewSelected:(MGDayView *)dayView
{
    //reset values
    [self resetValuesForDayView:_selectedDayView];
    
    //set new values
    _selectedDayView = dayView;
    _selectedDayView.backgroundColor = self.selectedDayViewBackgroundColor;
    _selectedDayView.dayLabel.textColor = self.selectedDayViewTextColor;
    _selectedDayView.dateLabel.textColor = self.selectedDayViewTextColor;
    _selectedDayView.layer.borderColor = self.selectedDayViewBorderColor.CGColor;

    //TODO - 
    //buggy
//    if (self.selectedDayView.date && ![self.selectedDayView.date isSameMonthAs:self.baseDate]) {
//        NSDate *date = self.selectedDayView.date;
//        self.baseDate = self.selectedDayView.date;
//        [self dayViewSelected:[self dayViewForDate:date]];
//    }
    
    if ([self.delegate respondsToSelector:@selector(calendarSelectedDate:)])
        [self.delegate calendarSelectedDate:self.selectedDayView.date];
}

#pragma mark - UIGesture methods
- (void) swipeRightGestureDetected:(UISwipeGestureRecognizer*)gesture {
    if (!self.isSwipeGestureEnabled)
        return;
    [self previousMonthAnimated:YES];
}

- (void) swipeLeftGestureDetected:(UISwipeGestureRecognizer*)gesture {
    if (!self.isSwipeGestureEnabled)
        return;
    [self nextMonthAnimated:YES];
}

#pragma mark -
#pragma mark - Setters
- (void) setBaseDate:(NSDate *)baseDate {
    _baseDate = baseDate;
    [self reloadData];
}

- (void) setDelegate:(id<MGCalendarViewDelegate>)delegate {
    _delegate = delegate;
    [self reloadData];
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
    [self resetValuesForDayView:self.selectedDayView];
    [self resetValuesForDayView:currentDayView];
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

- (void) setDayViewDotColor:(UIColor *)dayViewDotColor {
    [self setDayViewKey:@"dotView.backgroundColor" value:dayViewDotColor];
    _dayViewDotColor = dayViewDotColor;
}

- (void) setSelectedDayViewBackgroundColor:(UIColor *)selectedDayViewBackgroundColor {
    self.selectedDayView.backgroundColor = selectedDayViewBackgroundColor;
    _selectedDayViewBackgroundColor = selectedDayViewBackgroundColor;
}

- (void) setSelectedDayViewBorderColor:(UIColor *)selectedDayViewBorderColor {
    self.selectedDayView.layer.borderColor = selectedDayViewBorderColor.CGColor;
    _selectedDayViewBorderColor = selectedDayViewBorderColor;
}

- (void) setSelectedDayViewTextColor:(UIColor *)selectedDayViewTextColor {
    self.selectedDayView.dayLabel.textColor = selectedDayViewTextColor;
    self.selectedDayView.dateLabel.textColor = selectedDayViewTextColor;
    _selectedDayViewTextColor = selectedDayViewTextColor;
}

- (void) setCurrentDayViewBackgroundColor:(UIColor *)currentDayViewBackgroundColor {
    currentDayView.backgroundColor = currentDayViewBackgroundColor;
    _currentDayViewBackgroundColor = currentDayViewBackgroundColor;
}

- (void) setCurrentDayViewBorderColor:(UIColor *)currentDayViewBorderColor {
    currentDayView.layer.borderColor = currentDayViewBorderColor.CGColor;
    _currentDayViewBorderColor = currentDayViewBorderColor;
}

- (void) setCurrentDayViewTextColor:(UIColor *)currentDayViewTextColor {
    currentDayView.dayLabel.textColor = currentDayViewTextColor;
    currentDayView.dateLabel.textColor = currentDayViewTextColor;
    _currentDayViewTextColor = currentDayViewTextColor;
}


- (void) setDifferentMonthDayViewKey:(NSString*)key value:(id)value
{
    BOOL isKeyPath = ([key rangeOfString:@"."].location != NSNotFound);
    NSMutableArray *dates = [self.baseDate lastDatesInPreviousMonth];
    [dates addObjectsFromArray:[self.baseDate firstDatesInNextMonth]];
    for (NSDate *date in dates) {
        MGDayView *dayView = [self dayViewForDate:date];
        if (isKeyPath)
            [dayView setValue:value forKeyPath:key];
        else
            [dayView setValue:value forKey:key];
    }
}

- (void) setDifferentMonthDayViewBackgroundColor:(UIColor *)differentMonthDayViewBackgroundColor {
    [self setDifferentMonthDayViewKey:@"backgroundColor" value:differentMonthDayViewBackgroundColor];
    _differentMonthDayViewBackgroundColor = differentMonthDayViewBackgroundColor;
}

- (void) setDifferentMonthDayViewBorderColor:(UIColor *)differentMonthDayViewBorderColor {
    [self setDifferentMonthDayViewKey:@"layer.borderColor" value:(id)differentMonthDayViewBorderColor.CGColor];
    _differentMonthDayViewBorderColor = differentMonthDayViewBorderColor;
}

- (void) setDifferentMonthDayViewTextColor:(UIColor *)differentMonthDayViewTextColor {
    [self setDifferentMonthDayViewKey:@"dateLabel.textColor" value:differentMonthDayViewTextColor];
    [self setDifferentMonthDayViewKey:@"dayLabel.textColor" value:differentMonthDayViewTextColor];
    _differentMonthDayViewTextColor = differentMonthDayViewTextColor;
}

@end
