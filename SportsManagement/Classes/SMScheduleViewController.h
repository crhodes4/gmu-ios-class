//
//  SMScheduleViewController.h
//  SportsManagement
//
//  Created by Jason Harwig on 11/2/10.
//  Copyright 2010 Near Infinity Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMScheduleDetailedView.h"
#import "CalendarEvent.h"

@interface SMScheduleViewController : UITableViewController {
	NSMutableData *pulledData;
	NSMutableArray *eventsArray;
	UITableViewCell *nibLoadedCell;
	SMScheduleDetailedView *eventDetails;
	CalendarEvent *detailingEvent;
}


@property (nonatomic, retain) IBOutlet SMScheduleDetailedView *eventDetails;
@property (nonatomic, retain) NSMutableArray *eventsArray;
@property (nonatomic, retain) IBOutlet UITableViewCell *nibLoadedCell;


@end
