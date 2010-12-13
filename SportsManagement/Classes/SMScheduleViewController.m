//
//  SMScheduleViewController.m
//  SportsManagement
//
//  Created by Jason Harwig on 11/2/10.
//  Copyright 2010 Near Infinity Corporation. All rights reserved.
//

#import "SMScheduleViewController.h"
#import "CalendarEvent.h"
#import "SMScheduleDetailedView.h"
#import "SMLoginViewController.h"
#import "Utilities.h"

@implementation SMScheduleViewController

@synthesize eventsArray;
@synthesize venueArray;
@synthesize teamArray;
@synthesize gamesArray;
@synthesize eventDetails;
@synthesize venueDictionary;
@synthesize teamDictionary;
@synthesize gamesDictionary;




#pragma mark -
#pragma mark View lifecycle
#define GAMESURL @"http://nicsports.railsplayground.net/games.json"
#define VENUEURL @"http://nicsports.railsplayground.net/venues.json"
#define TEAMSURL @"http://nicsports.railsplayground.net/teams.json"

- (void)viewDidLoad {
    [super viewDidLoad];

	
	
	pulledData = [[NSMutableData alloc] init];
	pulledVenueData =[[NSMutableData alloc] init];
	pulledTeamData = [[NSMutableData alloc] init];
	venueDictionary =[[NSMutableDictionary alloc] init];
	teamDictionary = [[NSMutableDictionary alloc] init];
	eventsArray = [[NSMutableArray alloc] init];
	self.teamArray = [NSArray array];
	
}

- (void)viewDidAppear:(BOOL)animated
{
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:GAMESURL]];
	gamesConnection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
	
	NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:VENUEURL]];
	venueConnection = [[NSURLConnection connectionWithRequest:request2 delegate:self] retain];
	
	NSURLRequest *request3 = [NSURLRequest requestWithURL:[NSURL URLWithString:TEAMSURL]];
	teamConnection = [[NSURLConnection connectionWithRequest:request3 delegate:self] retain];

}

- (void) connection:(NSURLConnection *)connection didReceiveResponce:(NSURLResponse *)responce{
	if (connection == gamesConnection){
		[pulledData setLength:0];
	}else if (connection ==venueConnection) {
		[pulledVenueData setLength:0];
	}else if (connection == teamConnection) {
		[pulledTeamData setLength:0];
	} 
		
	

}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	if (connection == gamesConnection) {
		[pulledData appendData:data];
	}else if (connection == venueConnection){
		[pulledVenueData appendData:data];
	}else if (connection == teamConnection) {
		[pulledTeamData appendData:data];
	}

}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
	if (connection == gamesConnection) {
		self.gamesArray = [pulledData yajl_JSON];
		
	}else if (connection == venueConnection){
		self.venueArray = [pulledVenueData yajl_JSON];
		for (NSDictionary *venue in venueArray) {
			NSString *key = [venue objectForKey:@"id"];
			[venueDictionary setObject:venue forKey:key];
		}
	}else if (connection == teamConnection) {
		self.teamArray = [pulledTeamData yajl_JSON];
	
	
		for (NSDictionary *teams in teamArray) {
			NSString *key = [teams objectForKey:@"id"];
			[teamDictionary setObject:teams forKey:key];
		}
	}
	if ([gamesArray count] != 0 && [teamArray count] != 0 && [venueArray count] !=0 ) {
		for (NSDictionary *games in gamesArray) {
			NSNumber *gameId = [games valueForKey:@"id"];
			NSNumber *localVenueId = [games valueForKey:@"venue_id"];
			NSDate *gameStart = [Utilities dateFromCustomString:[games valueForKey:@"start_time"]];
			NSArray *teams = [games objectForKey:@"games_teams"];
			NSDictionary *team1 = [teams objectAtIndex:0];
			NSDictionary *team2 = [teams objectAtIndex:1];
			NSNumber *home = 0;
			NSNumber *away = 0;
			NSString *homeScore1 = 0;
			NSString *awayScore1 = 0;
			if ([[team1 objectForKey:@"home_team"] boolValue]) {
				home = [team1 valueForKey:@"team_id"];
				away = [team2 valueForKey:@"team_id"];
				if ([team1 valueForKey:@"score"] || [team2 valueForKey:@"score"]) {
					homeScore1 = [team1 valueForKey:@"score"];
					awayScore1 = [team2 valueForKey:@"score"];
				}else {
					homeScore1 = nil;
					awayScore1 = nil;
				}

				
				
				
			}else{
				home = [team2 valueForKey:@"team_id"];
				homeScore1 = [team2 valueForKey:@"score"];
				away = [team1 valueForKey:@"team_id"];
				awayScore1 = [team1 valueForKey:@"score"];
			}
			NSString *homeTeamName = [[teamDictionary objectForKey:home] valueForKey:@"name"];
			NSString *awayTeamName = [[teamDictionary objectForKey:away] valueForKey:@"name"];
			
			NSString *venueName = [[venueDictionary objectForKey:localVenueId] valueForKey:@"name"];
			NSString *venueAdd = [[venueDictionary objectForKey:localVenueId] valueForKey:@"street_address"];
			NSString *venueCity = [[venueDictionary objectForKey:localVenueId] valueForKey:@"city"];
			NSString *venueState = [[venueDictionary objectForKey:localVenueId] valueForKey:@"state"];
			NSString *venueZip = [[venueDictionary objectForKey:localVenueId] valueForKey:@"zip"];
			CalendarEvent *anEvent = [[CalendarEvent alloc] initWithTitle:gameId
																eventDate:gameStart
																venueName:venueName
																 homeTeam:homeTeamName
																 awayTeam:awayTeamName
																  venueID:localVenueId
															   addLineOne:venueAdd
																  addCity:venueCity
																 addState:venueState
																   addZip:venueZip
																homeScore:homeScore1
																awayScore:awayScore1
																homeStats:@"0-1"
																awayStats:@"1-0"];
			
			[eventsArray addObject:anEvent];
			[anEvent release];
		}
		[self.tableView reloadData];
	}
	
		
	
	
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	NSLog(@"error = %@", error);
}
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {

	SMLoginViewController *vc = [[SMLoginViewController alloc] initWithChallenge:challenge];
	[self presentModalViewController:vc animated:YES];
	[vc release];
	NSLog(@"showing login %@", self.modalViewController);
	if (self.modalViewController == nil) {
		NSLog(@"showing login view");
		SMLoginViewController *vc = [[SMLoginViewController alloc] initWithChallenge:challenge];
		[self presentModalViewController:vc animated:YES];
		[vc release];
	} else {
		[connection cancel];
	}

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [eventsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
		[[NSBundle mainBundle] loadNibNamed:@"schedulecell" owner:self options:NULL];
		cell = nibLoadedCell;
    }
	CalendarEvent *currentEvent = [eventsArray objectAtIndex:indexPath.row];
	UILabel *dateLabel = (UILabel*) [cell viewWithTag:2];
	dateLabel.text = [Utilities dayDateTimeStringOutput:[currentEvent eventDate]];
	UILabel *awayLabel = (UILabel*)[cell viewWithTag:1];
	awayLabel.text = currentEvent.awayTeam;
	UILabel *homeLabel = (UILabel*)[cell viewWithTag:3];
	homeLabel.text = currentEvent.homeTeam;
	UIImageView *imageView = (UIImageView*) [cell viewWithTag:6];
	if ([currentEvent.venueID nonretainedObjectValue] <= 1) {
		imageView.image = [UIImage imageNamed:@"home.png"];
	}else {
		imageView.image = [UIImage imageNamed:@"away.png"];
	}
	UILabel *homeStatsLabel = (UILabel*)[cell viewWithTag:4];
	homeStatsLabel.text = currentEvent.homeStats;
	UILabel *awayStatsLabel = (UILabel*)[cell viewWithTag:5];
	awayStatsLabel.text = currentEvent.awayStats;
	return cell;
	
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"selected row");
    eventDetails = [[SMScheduleDetailedView alloc] initWithNibName:@"SMScheduleDetailedView" bundle:nil];
	detailingEvent = [eventsArray objectAtIndex:indexPath.row];
	eventDetails.event = detailingEvent;
    [self.navigationController pushViewController:eventDetails animated:YES];
    

}
    

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
}

- (void)dealloc {
    [super dealloc];
	[gamesConnection release];
	[venueConnection release];
	[venueDictionary release];
	[pulledData release];
	[pulledVenueData release];
	[pulledTeamData release];
	[venueDictionary release];
	[teamDictionary release];
	[eventsArray release];
	[teamArray release];
	
}


@end

