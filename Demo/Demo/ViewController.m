//
//  ViewController.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    
    MGCalendarView *calView = [[MGCalendarView alloc] initWithPadding:5];
    CGPoint center = self.view.center;
    center.y = calView.frame.size.height*.5;
    calView.center = center;
    calView.delegate = self;
    [self.view addSubview:calView];
    
    UIImage *texture = [UIImage imageNamed:@"texture-gray"];
    calView.dayViewBackgroundColor = [UIColor colorWithPatternImage:texture];
    calView.dayViewBorderColor = [UIColor colorWithWhite:85 alpha:1];
    calView.dayViewBorderWidth = .5f;
    
    NSString *fontName = @"AvenirNext-Regular";
    UIFont *font = [UIFont fontWithName:fontName size:15];
    calView.dayViewDateFont = font;
    calView.dayViewDayFont = [UIFont fontWithName:fontName size:10];
    
    calView.selectedDayViewBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture-green"]];
    calView.selectedDayViewTextColor = [UIColor blackColor];
    calView.selectedDayViewBorderColor = [UIColor greenColor];
    
    calView.currentDayViewBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"texture-purple"]];
    calView.currentDayViewBorderColor = [UIColor colorWithRed:.933333333 green:.509803922 blue:.933333333 alpha:1];
    calView.currentDayViewTextColor = [UIColor blackColor];

    calView.monthLabel.font = [UIFont fontWithName:fontName size:40.0f];
    [calView reloadData];
    
//    calView.backgroundColor = [UIColor grayColor];
}

//jsut a helper method for creating fake dates to be marked!
- (NSDate*) currentDateWithDaysOffset:(NSInteger)offset {
    NSDate *currentDate = [NSDate date];
    return [currentDate dateByAddingTimeInterval:60*60*24*offset];
}


#pragma mark - MGCalendarViewDelegate methods
- (NSArray*) calendarMarkedDates {
    NSDate *dayBefore = [self currentDateWithDaysOffset:-2];
    NSDate *daysAfter = [self currentDateWithDaysOffset:3];
    return @[dayBefore, daysAfter];
}

@end
