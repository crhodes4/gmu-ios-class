//
//  SMScheduleDetailedView.h
//  SportsManagement
//
//  Created by SelectiveService on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CalendarEvent;
@class SMScheduleDetailedView;
@class SMLoginViewController;

@interface SMScheduleDetailedView : UIViewController {
	UILabel *eventDatelabel;
	UILabel *addLineOneLabel;
	UILabel *addCityLabel;
	UILabel *homeTeamLabel;
	UILabel *awayTeamLabel;
	UILabel *venueNameLabel;
	CalendarEvent *event;
	UISwitch *availSwitch;
	UIButton *addToCalendar;
	UIButton *mapIt;
}

- (IBAction) pushedMapIt: (id) sender;
- (IBOutlet) pushedAddToCalendar;

@property (nonatomic, retain) CalendarEvent *event;
@property (nonatomic, retain) IBOutlet UILabel *eventDatelabel;
@property (nonatomic, retain) IBOutlet UILabel *addLineOneLabel;
@property (nonatomic, retain) IBOutlet UILabel *addCityLabel;
@property (nonatomic, retain) IBOutlet UILabel *venueNameLabel;
@property (nonatomic, retain) IBOutlet UISwitch *availSwitch;
//@property (nonatomic, retain) IBAction UIButton *mapIt;
@property (nonatomic, retain) IBOutlet UIButton *addToCalendar;
@property (nonatomic, retain) IBOutlet UILabel *homeTeamLabel;
@property (nonatomic, retain) IBOutlet UILabel *awayTeamLabel;

@end
