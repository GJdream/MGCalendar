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

    MGCalendarView *view = [[MGCalendarView alloc] init];
    view.center = self.view.center;
    [self.view addSubview:view];
    
    UIImage *texture = [UIImage imageNamed:@"texture-gray"];
    view.dayViewBorderBackgroundColor = [UIColor colorWithPatternImage:texture];
    view.dayViewBorderColor = [UIColor colorWithWhite:85 alpha:1];
    view.dayViewBorderWidth = .5f;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
