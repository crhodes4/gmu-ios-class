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
//@synthesize detailingEvent;
@synthesize eventDetails;
@synthesize venueDictionary;
@synthesize teamDictionary;
@synthesize gamesDictionary;



#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle
#define GAMESURL @"http://nicsports.railsplayground.net/games.json"
#define VENUEURL @"http://nicsports.railsplayground.net/venues.json"
#define TEAMSURL @"http://nicsports.railsplayground.net/teams.json"

- (void)viewDidLoad {
    [super viewDidLoad];

	
	NSLog(@"View did Load");
	pulledData = [[NSMutableData alloc] init];
	pulledVenueData =[[NSMutableData alloc] init];
	pulledTeamData = [[NSMutableData alloc] init];
	venueDictionary =[[NSMutableDictionary alloc] init];
	teamDictionary = [[NSMutableDictionary alloc] init];
	eventsArray = [[NSMutableArray alloc] init];
	self.teamArray = [NSArray array];
	NSLog(@"viewdidload");
}

- (void)viewDidAppear:(BOOL)animated
{
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:GAMESURL]];
	gamesConnection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
	
	NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:VENUEURL]];
	venueConnection = [[NSURLConnection connectionWithRequest:request2 delegate:self] retain];
	
	NSURLRequest *request3 = [NSURLRequest requestWithURL:[NSURL URLWithString:TEAMSURL]];
	teamConnection = [[NSURLConnection connectionWithRequest:request3 delegate:self] retain];
	NSLog(@"teamConnection = %@", teamConnection);
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
		NSLog(@"results=%@", self.gamesArray);
	}else if (connection == venueConnection){
		self.venueArray = [pulledVenueData yajl_JSON];
		for (NSDictionary *venue in venueArray) {
			NSString *key = [venue objectForKey:@"id"];
			[venueDictionary setObject:venue forKey:key];
		}
		
		NSLog(@"venue results = %@", self.venueDictionary);
	}else if (connection == teamConnection) {
		self.teamArray = [pulledTeamData yajl_JSON];
		NSLog(@"team tesults = %@ %u", teamArray, [pulledTeamData length]);
	
		for (NSDictionary *teams in teamArray) {
			NSString *key = [teams objectForKey:@"id"];
			[teamDictionary setObject:teams forKey:key];
		}
	}
	if ([gamesArray count] != 0 && [teamArray count] != 0 && [venueArray count] !=0 ) {
		for (NSDictionary *games in gamesArray) {
			NSNumber *gameId = [games valueForKey:@"id"];
			NSNumber *venueId = [games valueForKey:@"venue_id"];
			NSDate *gameStart = [Utilities dateFromCustomString:[games valueForKey:@"start_time"]];
			NSArray *teams = [games objectForKey:@"games_teams"];
			NSDictionary *team1 = [teams objectAtIndex:0];
			NSDictionary *team2 = [teams objectAtIndex:1];
			NSNumber *home = 0;
			NSNumber *away = 0;
			if ([[team1 objectForKey:@"home_team"] boolValue]) {
				home = [team1 valueForKey:@"team_id"];
				away = [team2 valueForKey:@"team_id"];
				
			}else{
				home = [team2 valueForKey:@"team_id"];
				away = [team1 valueForKey:@"team_id"];
			}
			NSString *homeTeamName = [[teamDictionary objectForKey:home] valueForKey:@"name"];
			NSString *awayTeamName = [[teamDictionary objectForKey:away] valueForKey:@"name"];
			NSString *venueName = [[venueDictionary objectForKey:venueId] valueForKey:@"name"];
			NSString *venueAdd = [[venueDictionary objectForKey:venueId] valueForKey:@"street_address"];
			NSString *venueCity = [[venueDictionary objectForKey:venueId] valueForKey:@"city"];
			NSString *venueState = [[venueDictionary objectForKey:venueId] valueForKey:@"state"];
			NSString *venueZip = [[venueDictionary objectForKey:venueId] valueForKey:@"zip"];
			CalendarEvent *anEvent = [[CalendarEvent alloc] initWithTitle:gameId
																eventDate:gameStart
																venueName:venueName
																 homeTeam:homeTeamName
																 awayTeam:awayTeamName
																  venueID:venueId
															   addLineOne:venueAdd
																  addCity:venueCity
																 addState:venueState
																   addZip:venueZip
																homeStats:@"0-1"
																awayStats:@"1-0"];
			NSLog(@"events array = %@", [eventsArray class]);
			NSLog(@"calenderevent = %@", anEvent);
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
	
	//[self.tableView reloadData];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [eventsArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    //    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		
		[[NSBundle mainBundle] loadNibNamed:@"schedulecell" owner:self options:NULL];
		cell = nibLoadedCell;
    }
    
    // Configure the cell...
	CalendarEvent *currentEvent = [eventsArray objectAtIndex:indexPath.row];
	UILabel *dateLabel = (UILabel*) [cell viewWithTag:2];
	dateLabel.text = [Utilities dayDateTimeStringOutput:[currentEvent eventDate]];
	UILabel *awayLabel = (UILabel*)[cell viewWithTag:1];
	awayLabel.text = currentEvent.awayTeam;
	UILabel *homeLabel = (UILabel*)[cell viewWithTag:3];
	homeLabel.text = currentEvent.homeTeam;
	NSLog(@"home team = %@", currentEvent.homeTeam);
    return cell;
}


	
	
	
	
/*-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *) cell forRowAtIndexPath:(NSIndexPath *) indexPath{
	cell.backgroundColor = (indexPath.row%2)?[UIColor whiteColor]:[UIColor grayColor];
}*/
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"selected row");
    eventDetails = [[SMScheduleDetailedView alloc] initWithNibName:@"SMScheduleDetailedView" bundle:nil];
	detailingEvent = [eventsArray objectAtIndex:indexPath.row];
	eventDetails.event = detailingEvent;
//	NSLog(@"view controller = %d Event %d", eventDetails.event, detailingEvent);
    [self.navigationController pushViewController:eventDetails animated:YES];
    

}
    

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

/*-(NSDate *) dateFromCustomString:(NSString *) dateString{
	NSRange searchRange = NSMakeRange([dateString length] - 4 , 3);
	dateString = [dateString stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:searchRange];
	//dateString = [dateString stringByReplacingOccurrencesOfString:@"T" withString:@" "]; 
	NSLog(@"datestring %@", dateString);
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
	NSDate *myDate = [df dateFromString: dateString];
	NSLog(@"date = %@ mydate %@",[df stringFromDate:[NSDate date]], myDate);
	[df release];
	return myDate;
}
*/
- (void)dealloc {
    [super dealloc];
	[gamesConnection release];
	[venueConnection release];
	[venueDictionary release];
}


@end

