//
//  MGCalendarView.h
//  Demo
//
//  Created by Mark Glagola on 1/20/13.
//  Copyright (c) 2013 Mark Glagola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MGCalendarView : UIView {
    NSMutableArray *visibileDayViews;
}

//only set on init
@property (nonatomic, readonly) NSUInteger padding;

@property (nonatomic) UIColor *dayViewBorderColor;
@property (nonatomic) CGFloat dayViewBorderWidth;
@property (nonatomic) UIColor *dayViewBorderBackgroundColor;

//optional
//could just use init (Default padding = 1)
- (id) initWithPadding:(NSUInteger)padding;

@end
