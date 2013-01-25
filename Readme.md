# MGCalendar (MIT)
MGCalendar was made to be an easily customized calendar for iOS (See screenshots).

Feel free to improve or add features (making them easily customizable :) as well).  Let me know your changes by sending a pull request!

## Setup
- Drag and drop the MGCalendar/MGCalendar Folder into your project. (No need to add the demo…)

## MGCalendar Properties & Methods
The `baseDate` is the date in which the entire calendar is based on.  This is left as being settable but I recommend you avoid messing with the `baseDate` unless you are sure the date is valid.
`baseDate` is set the `[NSDate date];` by default.
```objc
@property (nonatomic) NSDate *baseDate; 
```

The `delegate` property is your typical delegate…
```objc
//the delegate property
@property (nonatomic) id<MGCalendarViewDelegate> delegate; 

//The protocol
@protocol MGCalendarViewDelegate <NSObject>
@optional
- (NSArray*) calendarMarkedDates;
- (void) calendarSelectedDate:(NSDate*)date;
- (void) calendarBaseDateUpdated:(NSDate*)date;
@end
```

The `isSwipeGestureEnabled` property dictates whether or not the swipe gesture (which changes months according to direction swiped) is enabled.
BY DEFAUL `isSwipeGestureEnabled` is YES 
```objc
@property (nonatomic) BOOL isSwipeGestureEnabled;
```

#### The Customization Methods
DayViews = The Actual Dates on the calendar, surrounded by a box (UIView).

##### Generic DayView properties.
These do not effect all DayViews, only those that are not a  selected view, current date view, or a different month view (will explain what this is in a bit..).
```objc
@property (nonatomic) UIColor *dayViewBorderColor;
@property (nonatomic) CGFloat dayViewBorderWidth;
@property (nonatomic) UIColor *dayViewBackgroundColor;
@property (nonatomic) UIFont *dayViewDateFont;
@property (nonatomic) UIFont *dayViewDayFont;
@property (nonatomic) UIColor *dayViewTextColor;
@property (nonatomic) UIColor *dayViewDotColor;
```

##### Selected DayView properties
Set these to edit the selected DayView. (the view that is selected by touch…)
```objc
@property (nonatomic) UIColor *selectedDayViewBackgroundColor;
@property (nonatomic) UIColor *selectedDayViewTextColor;
@property (nonatomic) UIColor *selectedDayViewBorderColor;
```

##### Current DayView properties
Set these to edit the current DayView. (the view that is shows what the current date is)
```objc
@property (nonatomic) UIColor *currentDayViewBackgroundColor;
@property (nonatomic) UIColor *currentDayViewBorderColor;
@property (nonatomic) UIColor *currentDayViewTextColor;
```

##### Current DayView properties
Set these to edit the DayViews that are not in the month (of the baseDate) but still visible in the calendar.
```objc
@property (nonatomic) UIColor *differentMonthDayViewBackgroundColor;
@property (nonatomic) UIColor *differentMonthDayViewBorderColor;
@property (nonatomic) UIColor *differentMonthDayViewTextColor;
```

## Demo
Checkout the demo for an example of how to use MGCalendar!

## Screenshots
Demo screenshot:
![ScreenShot 1](http://i1186.photobucket.com/albums/z367/markos7007/IMG_0862_zpsfb5b932d.png)

Crazy example:
![ScreenShot 2](http://i1186.photobucket.com/albums/z367/markos7007/IMG_0845_zpsd294cb8c.png)