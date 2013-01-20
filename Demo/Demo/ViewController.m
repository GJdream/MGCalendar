//
//  ViewController.m
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import "ViewController.h"
#import "MGCalendarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithWhite:.8 alpha:1];
    
    MGCalendarView *calView = [[MGCalendarView alloc] initWithPadding:5];
    calView.center = self.view.center;
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
    
    calView.monthLabel.font = [UIFont fontWithName:fontName size:40.0f];
    [calView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
