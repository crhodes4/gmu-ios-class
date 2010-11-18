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

@interface SMScheduleDetailedView : UIViewController {

	UILabel *addLineOneLabel;
	UILabel *addCityLabel;
	UILabel *addStateLabel;
	UILabel *addZipLabel;
	CalendarEvent *event;
	UISwitch *availSwitch;
}

@property (nonatomic, retain) CalendarEvent *event;
@property (nonatomic, retain) IBOutlet UILabel *addLineOneLabel;
@property (nonatomic, retain) IBOutlet UILabel *addCityLabel;
@property (nonatomic, retain) IBOutlet UILabel *addStateLabel;
@property (nonatomic, retain) IBOutlet UILabel *addZipLabel;
@property (nonatomic, retain) IBOutlet UISwitch *availSwitch;

@end
