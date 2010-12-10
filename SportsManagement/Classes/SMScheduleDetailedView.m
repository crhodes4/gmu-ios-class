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




-(void)viewWillAppear:(BOOL)animated{
	NSLog(@"made it to the SMScheduleDetaledClass");
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
	
	
	
	
}
- (void) pushedMapIt: (id) sender { 

	//NSString *theAddress = @"1600 Pennsylvania Ave NW Washington D.C., DC 20500";
	//NSString *aTitle = @"a title";
	//NSString *aSubtitle = @"a subtitle";
	
	MapKitDisplayViewController *maps = [[MapKitDisplayViewController alloc] init];
	// set var
	[self.navigationController pushViewController:maps animated:YES];
	[maps release];
	
}
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
