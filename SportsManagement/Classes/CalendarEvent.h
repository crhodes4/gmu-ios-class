//
//  CalendarEvent.h
//  SportsManagement
//
//  Created by SelectiveService on 11/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalendarEvent : NSObject {
	NSString *title;
	NSDate *eventDate;
	//NSString *time;
	NSString *oposingTeam;
	NSString *addLineOne;
	NSString *addCity;
	NSString *addState;
	NSString *addZip;
	NSString *gameLocation;
	NSString *homeStats;
	NSString *awayStats;
	
}


- (id)initWithTitle:(NSString *)newTitle 
		  eventDate:(NSDate *)newEventDate 
			   //time:(NSString *)newTime
		oposingTeam:(NSString *)newOpposingTeam
		 addLineOne:(NSString *)newAddLineOne
			addCity:(NSString *)newAddCity
		   addState:(NSString *)newAddState
			 addZip:(NSString *)newAddZip
	   gameLocation:(NSString *)newGameLocation
		  homeStats:(NSString *)newHomeStats
		  awayStats:(NSString *)newAwayStats;
	//playerAvailable:(BOOL *)newPlayerAvailable;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSDate *eventDate;
//@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *oposingTeam;
@property (nonatomic, retain) NSString *addLineOne;
@property (nonatomic, retain) NSString *addCity;
@property (nonatomic, retain) NSString *addState;
@property (nonatomic, retain) NSString *addZip;
@property (nonatomic, retain) NSString *gameLocation;
@property (nonatomic, retain) NSString *homeStats;
@property (nonatomic, retain) NSString *awayStats;
//@property (nonatomic, ) BOOL *playerAvailable;



@end
