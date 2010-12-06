//
//  SMScheduleViewController.m
//  SportsManagement
//
//  Created by Jason Harwig on 11/2/10.
//  Copyright 2010 Near Infinity Corporation. All rights reserved.
//

#import "SMScheduleViewController.h"
//#import "CalendarEvent.h"
#import "SMScheduleDetailedView.h"
#import "SMLoginViewController.h"

@implementation SMScheduleViewController

@synthesize eventsArray;
@synthesize venueArray;
@synthesize teamArray;
//@synthesize detailingEvent;
@synthesize eventDetails;
@synthesize venueDictionary;
@synthesize teamDictionary;



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
#define GAMESURL @"http://42.0.46.89:3000/games.json"//nicsports.railsplayground.net/games.json"
#define VENUEURL @"http://42.0.46.89:3000/venues.json"//nicsports.railsplayground.net/venues.json"
#define TEAMSURL @"http://42.0.46.89:3000/teams.json"//nicsports.railsplayground.net/teams.json"

- (void)viewDidLoad {
    [super viewDidLoad];

	
	NSLog(@"View did Load");
	pulledData = [[NSMutableData alloc] init];
	pulledVenueData =[[NSMutableData alloc] init];
	
	venueDictionary =[[NSMutableDictionary alloc] init];
	teamDictionary = [[NSMutableDictionary alloc] init];
	self.eventsArray = [NSArray array];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:GAMESURL]];
	gamesConnection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
	
	NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:VENUEURL]];
	venueConnection = [[NSURLConnection connectionWithRequest:request2 delegate:self] retain];
	
	NSURLRequest *request3 = [NSURLRequest requestWithURL:[NSURL URLWithString:VENUEURL]];
	teamConnection = [[NSURLConnection connectionWithRequest:request3 delegate:self] retain];
	
	for (NSDictionary *venue in venueArray) {
		NSString *key = [venue objectForKey:@"id"];
		[venueDictionary setObject:venue forkey:key];
	}
	
	for (NSDictionary *teams in teamArray) {
		NSString *key = [teams objectForKey:@"id"];
		[teamDictionary setObject:teams forkey:key];
	}
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
		self.eventsArray = [pulledData yajl_JSON];
		NSLog(@"results=%@", self.eventsArray);
	}else if (connection == venueConnection){
		self.venueArray = [pulledVenueData yajl_JSON];
		NSLog(@"venue results = %@", self.venueArray);
	}else if (connection == teamConnection) {
		self.teamArray = [pulledTeamData yajl_JSON];
		NSLog(@"team tesults = %@", self.teamArray);
	}

	[self.tableView reloadData];
	
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
SMLoginViewController *vc = [[SMLoginViewController alloc] initWithChallenge:challenge];
[self presentModalViewController:vc animated:YES];
[vc release];
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
    NSLog(@"%d", eventsArray);
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    //    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		
		[[NSBundle mainBundle] loadNibNamed:@"schedulecell" owner:self options:NULL];
		cell = nibLoadedCell;
    }
    
    // Configure the cell...
	NSDictionary *data = [eventsArray objectAtIndex:indexPath.row];
	CalendarEvent *anEvent = [[CalendarEvent alloc] init]; 
	anEvent.title = [data objectForKey:@"id"];
	anEvent.venueID = [data objectForKey:@"venue_id"];
	//NSNumber *venueID = [[anEvent venueID] stringValue];
	NSDictionary *venueDict = [venueArray objectAtIndex:[anEvent venueID]];
	anEvent.venueName = [venueDict objectForKey:@"name"];
	anEvent.addLineOne = [venueDict objectForKey:@"street_address"];
	anEvent.addCity = [venueDict objectForKey:@"city"];
	anEvent.addState = [venueDict objectForKey:@"state"];
	anEvent.addZip = [venueDict objectForKey:@"zip"];
//	titleLabel.text = [[data objectForKey:@"season_id"] stringValue];
	NSArray *teams = [data objectForKey:@"games_teams"];
	NSDictionary *team1 = [teams objectAtIndex:0];
	NSDictionary *team2 = [teams objectAtIndex:1];
	
	if ([[team1 objectForKey:@"home_team"] boolValue]) {
		//NSNumber *home = [team1 objectForKey:@"team_id"];
		//NSNumber *away = [team2 objectForKey:@"team_id"];
		anEvent.homeTeam = [team1 objectForKey:@"team_name"];
		anEvent.awayTeam = [team2 objectForKey:@"team_name"];
		
	}else{
		//NSNumber *home = [team2 objectForKey:@"team_id"];
		//NSNumber *away = [team1 objectForKey:@"team_id"];
		anEvent.homeTeam = [team2 objectForKey:@"team_name"];
		anEvent.awayTeam = [team1 objectForKey:@"team_name"];
	}
	UILabel *awayLabel = (UILabel*)[cell viewWithTag:1];
	awayLabel.text = anEvent.awayTeam;
	UILabel *homeLabel = (UILabel*)[cell viewWithTag:3];
	homeLabel.text = anEvent.homeTeam;
	
	anEvent.eventDate = [self dateFromCustomString: [data objectForKey:@"start_time"]];
	//Date formatter
	UILabel *dateLabel = (UILabel*) [cell viewWithTag:2];
/*	NSDateFormatter* dateFormater = [[NSDateFormatter alloc] init];
	[dateFormater setDateFormat:@"E, M/d/Y   hh:mm"];//hh:mm dd-MM-YYYY B"];
	NSString *dateString = [dateFormater stringFromDate:anEvent.eventDate];
	eventLabel.text = dateString;
*/	//NSLog(@"anevent %@ string %@",anEvent.eventDate, dateString );
	dateLabel.text = [anEvent.eventDate dayDateTimeStringOutput];
	UIImageView *imageView = (UIImageView*) [cell viewWithTag:5];
	if (anEvent.venueID == @"1") {
		imageView.image = [UIImage imageNamed:@"home.png"];
	}else {
		imageView.image = [UIImage imageNamed:@"away.png"];
	}
	
	UILabel *homeStatsLabel =(UILabel*) [cell viewWithTag:6];
	homeStatsLabel.text = anEvent.homeStats;
	UILabel *awayStatsLabel =(UILabel*) [cell viewWithTag:7];
	awayStatsLabel.text = anEvent.awayStats;
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
	NSLog(@"view controller = %d Event %d", eventDetails.event, detailingEvent);
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
/*
-(NSDate *) dateFromCustomString:(NSString *) dateString{
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

