//
//  ViewController.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+Calendar.h"
#import "SectionView.h"

@interface ViewController () {
    IBOutlet UILabel *monthLabel;
    IBOutlet UILabel *yearLabel;
    IBOutlet SectionView *headerView;

    IBOutlet UILabel *selectedDateLabel;
    
    NSArray *selectedDates;
}

@property (nonatomic, readonly) MGCalendarView *calView;

@end

@implementation ViewController

@synthesize calView = _calView;

//would be ideal to subclass MGCalendarView
//but for the sake of the demo...
- (MGCalendarView*) calView
{
    if (!_calView) {
        _calView = [[MGCalendarView alloc] initWithPadding:5 width:self.view.frame.size.width-20];
        _calView.delegate = self;
        
        UIImage *texture = [UIImage imageNamed:@"texture-gray"];
        _calView.dayViewBackgroundColor = [UIColor colorWithPatternImage:texture];
        _calView.dayViewBorderColor = [UIColor colorWithWhite:85 alpha:1];
        _calView.dayViewBorderWidth = .5f;
        
        NSString *fontName = @"HelveticaNeue-Light";
        UIFont *font = [UIFont fontWithName:fontName size:15];
        _calView.dayViewDateFont = font;
        _calView.dayViewDayFont = [UIFont fontWithName:fontName size:10];
        
        _calView.selectedDayViewBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture-green"]];
        _calView.selectedDayViewTextColor = [UIColor blackColor];
        _calView.selectedDayViewBorderColor = [UIColor greenColor];
        
        _calView.currentDayViewBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture-purple"]];
        _calView.currentDayViewBorderColor = [UIColor colorWithRed:.933333333 green:.509803922 blue:.933333333 alpha:1];
        _calView.currentDayViewTextColor = [UIColor blackColor];
        
        _calView.differentMonthDayViewBackgroundColor = [UIColor colorWithWhite:.85 alpha:1];
        _calView.differentMonthDayViewBorderColor = [UIColor colorWithWhite:.9 alpha:1];
        _calView.differentMonthDayViewTextColor = [UIColor lightGrayColor];
        
        _calView.layer.shadowOffset = CGSizeMake(0, 0);
        _calView.layer.shadowOpacity = .5f;
        _calView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        
        _calView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin |
                                    UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    }
    return _calView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    NSDate *daysBefore = [self currentDateWithDaysOffset:-2];
    NSDate *daysAfter = [self currentDateWithDaysOffset:3];
    selectedDates = @[daysBefore, daysAfter];
    
    NSString *fontName = @"HelveticaNeue-Light";
    monthLabel.font = [UIFont fontWithName:fontName size:monthLabel.font.pointSize];
    yearLabel.font = [UIFont fontWithName:fontName size:yearLabel.font.pointSize];
    headerView.layer.shadowOffset = CGSizeMake(0, 3);
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture-gray"]];
    selectedDateLabel.text = @"";
    
    //add calendar to view
    [self.view addSubview:self.calView];
    self.calView.center = self.view.center;
}

//just a helper method for creating fake dates for the demo!
- (NSDate*) currentDateWithDaysOffset:(NSInteger)offset {
    NSDate *currentDate = [NSDate date];
    return [currentDate dateByAddingTimeInterval:60*60*24*offset];
}


#pragma mark - MGCalendarViewDelegate methods
- (NSArray*) calendarMarkedDates {
    return selectedDates;
}

- (void) calendarSelectedDate:(NSDate*)date {
    
    if (!date)
        return;
    
    selectedDateLabel.text = [date stringFromDateWithFormat:@"EEE, LLLL dd"];
    selectedDateLabel.textColor = [UIColor blackColor]; //reset color
    
    //highlight the selectedDates
    for (NSDate *selectedDate in selectedDates) {
        if ([selectedDate isSameDayAs:date]) {
            selectedDateLabel.textColor = self.calView.dayViewDotColor;
            break;
        }
    }
    
    
}

- (void) calendarBaseDateUpdated:(NSDate *)date {
    monthLabel.text = [date monthName];
    yearLabel.text = [date stringFromDateWithFormat:@"yyyy"];
}

#pragma mark - Button Actions
- (IBAction)rightButtonPressed:(id)sender {
    [self.calView nextMonthAnimated:YES];
}

- (IBAction)leftButtonPressed:(id)sender {
    [self.calView previousMonthAnimated:YES];
}

@end
