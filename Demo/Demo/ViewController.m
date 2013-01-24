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
    
    NSArray *selectedDates;
}

@end

@implementation ViewController

//just a helper method for creating fake dates for the demo!
- (NSDate*) currentDateWithDaysOffset:(NSInteger)offset {
    NSDate *currentDate = [NSDate date];
    return [currentDate dateByAddingTimeInterval:60*60*24*offset];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //just making labels match rest of fonts..
    NSString *fontName = @"HelveticaNeue-Light";
    monthLabel.font = [UIFont fontWithName:fontName size:monthLabel.font.pointSize];
    yearLabel.font = [UIFont fontWithName:fontName size:yearLabel.font.pointSize];
    
    self.view.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    selectedDateLabel.text = @"";
    
    NSDate *daysBefore = [self currentDateWithDaysOffset:-2];
    NSDate *daysAfter = [self currentDateWithDaysOffset:3];
    selectedDates = @[daysBefore, daysAfter];
    
    
    //-----------------CUSTOMIZING/ADDING Calendar-------------------//
    //create view with padding (optional)
    //Default is 5
//    calView = [[MGCalendarView alloc] initWithPadding:5]; //this autocacluates frame (width will always be fixed)
    calView = [[MGCalendarView alloc] initWithPadding:5 width:self.view.frame.size.width-20];
    CGRect frame = calView.frame;
    frame.origin.y = yearLabel.frame.origin.y + yearLabel.frame.size.height + 15;
    frame.origin.x = self.view.frame.size.width*.5 - frame.size.width*.5;
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
    
    calView.differentMonthDayViewBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture-purple"]];
    calView.differentMonthDayViewBorderColor = [UIColor colorWithRed:.933333333 green:.509803922 blue:.933333333 alpha:1];
    calView.differentMonthDayViewTextColor = [UIColor blackColor];

    
    //always a good idea to reloadData after customizing (even in subclass)
    //No need to call reloadData after setting dayView attributes - auto reloads for you
    //However, calView does not auto reload when setting currentDayViewBlahBlah, selectedDayViewBlahBlah, etc.
//    [calView reloadData];
}


#pragma mark - MGCalendarViewDelegate methods
- (NSArray*) calendarMarkedDates {
    return selectedDates;
}

- (void) calendarSelectedDate:(NSDate*)date {
    selectedDateLabel.text = [date stringFromDateWithFormat:@"EEE, LLLL dd"];
    selectedDateLabel.textColor = [UIColor blackColor]; //reset color
    
    //highlight the selectedDates
    for (NSDate *selectedDate in selectedDates) {
        if ([selectedDate isSameDayAs:date]) {
            selectedDateLabel.textColor = calView.dayViewDotColor;
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
    [calView nextMonthAnimated:YES];
}

- (IBAction)leftButtonPressed:(id)sender {
    [calView previousMonthAnimated:YES];
}

@end
