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

@implementation SMScheduleViewController

@synthesize eventsArray;
//@synthesize detailingEvent;
@synthesize eventDetails;


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



- (void)viewDidLoad {
    [super viewDidLoad];

	NSLog(@"View did Load");
	
	self.eventsArray = [NSMutableArray array];
	CalendarEvent *game = [[CalendarEvent alloc] initWithTitle:@"VS VTECH"
						   
													 eventDate:[self dateFromCustomString: @"2010-12-10 12:00:00 +500"]
														//  time:@"12:00"
												   oposingTeam:@"Virginia Tech"
													addLineOne:@"123 Main Street"
													   addCity:@"noWhere"
													  addState:@"Virginia"
														addZip:@"22209"
													  gameLocation:@"h"
													 homeStats:@"50-0"
													 awayStats:@"25-25"];
						   
	[eventsArray addObject:game];
	[game release];
	game = [[CalendarEvent alloc] initWithTitle:@"VS GMU" 
									  eventDate:@"2010-12-10"
								//		   time:@"12:30"
									oposingTeam:@"Duke"
									 addLineOne:@"123 Main Street"
										addCity:@"noWhere"
									   addState:@"Virginia"
										 addZip:@"22209"
									   gameLocation:@"h"
									  homeStats:@"50-0"
									  awayStats:@"25-25"];
	
	[eventsArray addObject:game];
	[game release];
	game = [[CalendarEvent alloc] initWithTitle:@"VS LSU"
									  eventDate:@"2010-31-10"
								//		   time:@"1:00"
									oposingTeam:@"LSU"
									 addLineOne:@"123 Main Street"
										addCity:@"noWhere"
									   addState:@"Virginia"
										 addZip:@"22209"
									   gameLocation:@"a"
									  homeStats:@"50-0"
									  awayStats:@"25-25"];
	
	[eventsArray addObject:game];
	[game release];
	game = [[CalendarEvent alloc] initWithTitle:@"VS NC State"
									  eventDate:@"2010-12-10"
								//		   time:@"1:30"
									oposingTeam:@"NC State"
									 addLineOne:@"123 Main Street"
										addCity:@"noWhere"
									   addState:@"Virginia"
										 addZip:@"22209"
									   gameLocation:@"a"
									  homeStats:@"50-0"
									  awayStats:@"25-25"];
	
	[eventsArray addObject:game];
	[game release];
	
	
/*	pulledData = [[NSMutableData alloc] init];
	self.pulledResults = [NSArray array];
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:GAMESURL]];
	[NSURLConnection connectionWithRequest:request delegate:self];
					  
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) connection:(NSURLConnection *)connection didReceiveResponce:(NSURLResponse *)responce{
	[pulledData setLength:0];
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[pulledData appendData:data];
}
-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
	self.pulledResults = [pulledData yajl_JSON];
	NSLog(@"results=%@", self.pulledResults);
*/	
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
	CalendarEvent *anEvent = [eventsArray objectAtIndex:indexPath.row];
	UILabel *titleLabel = (UILabel*)[cell viewWithTag:1];
	titleLabel.text = anEvent.title;
//	cell.textLabel.text = anEvent.title;
	UILabel *eventLabel = (UILabel*) [cell viewWithTag:2];
	eventLabel.text = anEvent.eventDate;
	UILabel *teamlabel = (UILabel*) [cell viewWithTag:3];
	teamlabel.text = anEvent.oposingTeam;
//	UILabel *timeLabel = (UILabel*) [cell viewWithTag:4];
//	timeLabel.text = anEvent.time;
	UIImageView *imageView = (UIImageView*) [cell viewWithTag:5];
	if (anEvent.gameLocation == @"h") {
		imageView.image = [UIImage imageNamed:@"home.tiff"];
	}else {
		imageView.image = [UIImage imageNamed:@"away.tiff"];
	}
	UILabel *homeStatsLabel =(UILabel*) [cell viewWithTag:6];
	homeStatsLabel.text = anEvent.homeStats;
	UILabel *awayStatsLabel =(UILabel*) [cell viewWithTag:7];
	awayStatsLabel.text = anEvent.awayStats;
NSLog(@"entered if %d", anEvent.eventDate);

//	cell.textLabel.text = 
    
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

-(NSDate *) dateFromCustomString:(NSString *) dateString{
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
	NSDate *myDate = [df dateFromString: dateString];
	return myDate;
}

- (void)dealloc {
    [super dealloc];
}


@end

