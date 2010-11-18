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
//@synthesize time;
@synthesize oposingTeam;
@synthesize addLineOne;
@synthesize addCity;
@synthesize addState;
@synthesize addZip;
@synthesize gameLocation;
@synthesize homeStats;
@synthesize awayStats;

//@synthesize playerAvailable;

-(id)initWithTitle:(NSString *)newTitle 
		 eventDate:(NSDate *)newEventDate 
			//  time:(NSString *)newTime
	   oposingTeam:(NSString *)newOpposingTeam
		addLineOne:(NSString *)newAddLineOne
		   addCity:(NSString *)newAddCity
		  addState:(NSString *)newAddState
			addZip:(NSString *)newAddZip
	  gameLocation:(NSString *)newGameLocation
		 homeStats:(NSString *)newHomeStats
		 awayStats:(NSString *)newAwayStats{
	
	self = [super init];
	if (nil != self) {
		self.title = newTitle;
		 
		self.eventDate = newEventDate;
		//self.time = newTime;
		self.oposingTeam = newOpposingTeam;
		self.addLineOne = newAddLineOne;
		self.addCity = newAddCity;
		self.addState = newAddState;
		self.addZip = newAddZip;
		self.gameLocation = newGameLocation;
		self.homeStats = newHomeStats;
		self.awayStats = newAwayStats;
	} return self;
}
-(void) dealloc {
	[title release];
	[eventDate release];
//	[time release];
	[oposingTeam release];
	[addLineOne release];
	[addCity release];
	[addState release];
	[addZip release];
	[gameLocation release];
	[homeStats release];
	[awayStats release];
	[super dealloc];
}

@end
