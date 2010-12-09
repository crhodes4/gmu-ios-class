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
#import "SMLoginViewController.h"
#import "Utilities.h"

@interface SMScheduleViewController : UITableViewController {
	NSMutableData *pulledData;
	NSMutableData *pulledVenueData;
	NSMutableData *pulledTeamData;
	NSMutableArray *eventsArray;
	NSArray *gamesArray;
	NSArray *venueArray;
	NSArray *teamArray;
	UITableViewCell *nibLoadedCell;
	SMScheduleDetailedView *eventDetails;
	CalendarEvent *detailingEvent;
	NSURLConnection *gamesConnection;
	NSURLConnection *venueConnection;
	NSURLConnection *teamConnection;
	NSMutableDictionary *venueDictionary;
	NSMutableDictionary *teamDictionary;
	NSMutableDictionary *gamesDictionary;
	
}


@property (nonatomic, retain) IBOutlet SMScheduleDetailedView *eventDetails;
@property (nonatomic, retain) NSMutableArray *eventsArray;
@property (nonatomic, retain) NSArray *gamesArray;
@property (nonatomic, retain) NSArray *venueArray;
@property (nonatomic, retain) NSArray *teamArray;
@property (nonatomic, retain) NSMutableDictionary *venueDictionary;
@property (nonatomic, retain) NSMutableDictionary *teamDictionary;
@property (nonatomic, retain) NSMutableDictionary *gamesDictionary;
@property (nonatomic, retain) IBOutlet UITableViewCell *nibLoadedCell;


@end
