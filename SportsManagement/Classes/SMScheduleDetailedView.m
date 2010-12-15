//
//  SMScheduleDetailedView.m
//  SportsManagement
//
//  Created by SelectiveService on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
 
#import "SMScheduleDetailedView.h"
#import "CalendarEvent.h"
#import "SMLoginViewController.h"
#import <EventKit/EventKit.h>
#import "Utilities.h"
#import "MapKitDisplayViewController.h"


@implementation SMScheduleDetailedView

@synthesize event;
@synthesize eventDatelabel;
@synthesize addLineOneLabel;
@synthesize addCityLabel;
@synthesize homeTeamLabel;
@synthesize awayTeamLabel;
@synthesize availSwitch;
@synthesize venueNameLabel;
@synthesize homeScoreLabel;
@synthesize awayScoreLabel;




-(void)viewWillAppear:(BOOL)animated{
	
	[super viewWillAppear:animated];
		
	NSLog(@"count %d", [[availSwitch subviews] count]);
	NSLog(@"availSwitch is %@", availSwitch);
	
	for (UIView *subview in [availSwitch subviews])  
    {  
        if ([subview isKindOfClass:[UILabel class]])  
        {  
			NSLog(@"Found a UILabel");
            [subview setText:@"Yes"];
        }  
        else   
            NSLog(@"No label subview found");;  
    }  
	eventDatelabel.text = [Utilities dayDateTimeStringOutput:event.eventDate ];
	homeTeamLabel.text = event.homeTeam;
	awayTeamLabel.text = event.awayTeam;
	venueNameLabel.text = [NSString stringWithFormat:@"@ %@",event.venueName];
	addLineOneLabel.text = event.addLineOne;
	addCityLabel.text = [NSString stringWithFormat:@"%@ ,%@ %@", event.addCity, event.addState, event.addZip];
	if (event.homeScore == [NSNull null]) {
		homeScoreLabel.text = @"";
		awayScoreLabel.text = @"";
	}else {
		homeScoreLabel.text = [event.homeScore stringValue];
		awayScoreLabel.text = [event.awayScore stringValue];
	}

}
- (void) pushedMapIt: (id) sender { 

	mapEvent = [[MapKitDisplayViewController alloc] initWithNibName:@"MapKitDisplayViewController" bundle:nil];
	mapEvent.mapEvents = event;
	[self.navigationController pushViewController:mapEvent animated:YES];

//- (IBAction) pushedMapIt{  
	NSString *venueAdd1 = event.addLineOne;
	
	NSString *venueAdd2 = [NSString stringWithFormat:@"%@ ,%@ %@", event.addCity, event.addState, event.addZip];
	
	
	
//	MapKitDisplayViewController *maps = [[MapKitDisplayViewController alloc] init];
	// set var
	
	
//	[self.navigationController pushViewController:maps animated:YES];
	[mapEvent release];

	
}
///*
-  mapItDetails { 
 
	NSString *venueAdd1 = event.addLineOne;
	NSLog(@"venueAdd1 = %@", venueAdd1);
	NSString *venueAdd2 = [NSString stringWithFormat:@"%@ ,%@ %@", event.addCity, event.addState, event.addZip];
	NSLog(@"venueAdd2 = %@", venueAdd2);
	NSString *venueAdd = [NSString stringWithFormat:@"%@ %@", venueAdd1, venueAdd2];
	NSLog(@"venueAdd = %@", venueAdd);
	
	NSLog(@"Made it to mapItDetails");

	return venueAdd;
} //*/


- (IBAction) pushedAddToCalendar{
	EKEventStore *eventStore = [[EKEventStore alloc] init];
	EKEvent *newEvent = [EKEvent eventWithEventStore:eventStore];
	
	newEvent.title = [NSString stringWithFormat:@"%@ vs %@", event.awayTeam, event.homeTeam];
	newEvent.startDate = event.eventDate;
	
	[newEvent setCalendar:[eventStore defaultCalendarForNewEvents]];
	NSError *err;
	[eventStore saveEvent:newEvent span:EKSpanThisEvent error:&err];
	
}
- (void)loadView
{
	[super loadView];
}
- (void)didReceiveMemoryWarning {
 
    [super didReceiveMemoryWarning];
    
   }

- (void)viewDidUnload {
    [super viewDidUnload];
 }


- (void)dealloc {
    [super dealloc];
	
}


@end
