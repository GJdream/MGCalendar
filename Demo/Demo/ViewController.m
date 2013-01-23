//
//  ViewController.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+Calendar.h"

@interface ViewController () {
    IBOutlet UILabel *monthLabel;
    IBOutlet UILabel *yearLabel;

    IBOutlet UILabel *selectedDateLabel;
    MGCalendarView *calView;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //just making labels match rest of fonts..
    NSString *fontName = @"AvenirNext-Regular";
    monthLabel.font = [UIFont fontWithName:fontName size:monthLabel.font.pointSize];
    yearLabel.font = [UIFont fontWithName:fontName size:yearLabel.font.pointSize];
    
    self.view.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    selectedDateLabel.text = @"";
    
    //create view with padding (optional)
    //Default is 5
    calView = [[MGCalendarView alloc] initWithPadding:5];
    CGRect frame = calView.frame;
    frame.origin.y = yearLabel.frame.origin.y + yearLabel.frame.size.height + 15;
    calView.frame = frame;
    calView.delegate = self;
    [self.view addSubview:calView];
    
    //Customize your Calendar
    //Every calendar "dayView" is just a custom UIView...
    //Customization is endless!
    UIImage *texture = [UIImage imageNamed:@"texture-gray"];
    calView.dayViewBackgroundColor = [UIColor colorWithPatternImage:texture];
    calView.dayViewBorderColor = [UIColor colorWithWhite:85 alpha:1];
    calView.dayViewBorderWidth = .5f;
    
    UIFont *font = [UIFont fontWithName:fontName size:15];
    calView.dayViewDateFont = font;
    calView.dayViewDayFont = [UIFont fontWithName:fontName size:10];
    
    calView.selectedDayViewBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture-green"]];
    calView.selectedDayViewTextColor = [UIColor blackColor];
    calView.selectedDayViewBorderColor = [UIColor greenColor];
    
    calView.currentDayViewBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture-purple"]];
    calView.currentDayViewBorderColor = [UIColor colorWithRed:.933333333 green:.509803922 blue:.933333333 alpha:1];
    calView.currentDayViewTextColor = [UIColor blackColor];

    //always a good idea to reloadData after customizing (even in subclass)
    //No need to call reloadData after setting dayView attributes - auto reloads for you
    //However, calView does not auto reload when setting currentDayViewBlahBlah, selectedDayViewBlahBlah, etc.
    [calView reloadData];
}

//jsut a helper method for creating fake dates to be marked!
- (NSDate*) currentDateWithDaysOffset:(NSInteger)offset {
    NSDate *currentDate = [NSDate date];
    return [currentDate dateByAddingTimeInterval:60*60*24*offset];
}


#pragma mark - MGCalendarViewDelegate methods
- (NSArray*) calendarMarkedDates {
    NSDate *daysBefore = [self currentDateWithDaysOffset:-2];
    NSDate *daysAfter = [self currentDateWithDaysOffset:3];
    return @[daysBefore, daysAfter];
}

- (void) calendarSelectedDate:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE, LLLL dd"];
    selectedDateLabel.text = [formatter stringFromDate:date];
}

- (void) calendarBaseDateUpdated:(NSDate *)date {
    monthLabel.text = [date monthName];
    yearLabel.text = [date stringFromDateWithFormat:@"yyyy"];
}

#pragma mark - Button Actions
- (IBAction)rightButtonPressed:(id)sender {
    [calView nextMonthAnimated:YES];
}

- (IBAction)leftButtonPressed:(id)sender {
    [calView previousMonthAnimated:YES];
}

@end
