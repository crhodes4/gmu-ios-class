//
//  CalendarEvent.m
//  SportsManagement
//
//  Created by SelectiveService on 11/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CalendarEvent.h"


@implementation CalendarEvent

@synthesize title;
@synthesize eventDate;
@synthesize venueName;
@synthesize homeTeam;
@synthesize awayTeam;
@synthesize venueID;
@synthesize addLineOne;
@synthesize addCity;
@synthesize addState;
@synthesize addZip;

@synthesize homeStats;
@synthesize awayStats;

//@synthesize playerAvailable;

-(id)initWithTitle:(NSNumber *)newTitle 
		 eventDate:(NSDate *)newEventDate 
		 venueName:(NSString *)newVenueName
		  homeTeam:(NSString *)newHomeTeam
		  awayTeam:(NSString *)newAwayTeam
		   venueID:(NSNumber *)newVenueID
		addLineOne:(NSString *)newAddLineOne
		   addCity:(NSString *)newAddCity
		  addState:(NSString *)newAddState
			addZip:(NSString *)newAddZip

		 homeStats:(NSString *)newHomeStats
		 awayStats:(NSString *)newAwayStats{
	
	self = [super init];
	if (nil != self) {
		self.title = newTitle;
		 
		self.eventDate = newEventDate;
		self.venueName = newVenueName;
		self.homeTeam = newHomeTeam;
		self.awayTeam = newAwayTeam;
		self.venueID - newVenueID;
		self.addLineOne = newAddLineOne;
		self.addCity = newAddCity;
		self.addState = newAddState;
		self.addZip = newAddZip;
	
		self.homeStats = newHomeStats;
		self.awayStats = newAwayStats;
	} return self;
}
-(void) dealloc {
	[title release];
	[eventDate release];
	[venueName release];
	[homeTeam release];
	[awayTeam release];
	[venueID release];
	[addLineOne release];
	[addCity release];
	[addState release];
	[addZip release];

	[homeStats release];
	[awayStats release];
	[super dealloc];
}

@end
