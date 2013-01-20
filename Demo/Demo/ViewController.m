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
    
    MGCalendarView *view = [[MGCalendarView alloc] initWithPadding:5];
    view.center = self.view.center;
    [self.view addSubview:view];
    
    UIImage *texture = [UIImage imageNamed:@"texture-gray"];
    view.dayViewBackgroundColor = [UIColor colorWithPatternImage:texture];
    view.dayViewBorderColor = [UIColor colorWithWhite:85 alpha:1];
    view.dayViewBorderWidth = .5f;
    
    UIFont *font = [UIFont fontWithName:@"AvenirNext-Regular" size:15];
    view.dayViewDateFont = font;
    view.dayViewDayFont = [UIFont fontWithName:@"AvenirNext-Regular" size:10];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
