//
//  CalendarEvent.h
//  SportsManagement
//
//  Created by SelectiveService on 11/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalendarEvent : NSObject {
	NSNumber *title;
	NSDate *eventDate;
	NSString *venueName;
	NSString *homeTeam;
	NSString *awayTeam;
	NSNumber *venueID;
	NSString *addLineOne;
	NSString *addCity;
	NSString *addState;
	NSString *addZip;

	NSString *homeStats;
	NSString *awayStats;
	
}


- (id)initWithTitle:(NSNumber *)newTitle 
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
		  awayStats:(NSString *)newAwayStats;
	//playerAvailable:(BOOL *)newPlayerAvailable;

@property (nonatomic, retain) NSNumber *title;
@property (nonatomic, retain) NSDate *eventDate;
@property (nonatomic, retain) NSString *venueName;
@property (nonatomic, retain) NSString *homeTeam;
@property (nonatomic, retain) NSString *awayTeam;
@property (nonatomic, retain) NSNumber *venueID;
@property (nonatomic, retain) NSString *addLineOne;
@property (nonatomic, retain) NSString *addCity;
@property (nonatomic, retain) NSString *addState;
@property (nonatomic, retain) NSString *addZip;
@property (nonatomic, retain) NSString *homeStats;
@property (nonatomic, retain) NSString *awayStats;
//@property (nonatomic, ) BOOL *playerAvailable;



@end
