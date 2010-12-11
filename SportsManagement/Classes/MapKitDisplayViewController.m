//
//  MapKitDisplayViewController.m
//  MapKitDisplay
//

#import "MapKitDisplayViewController.h"
#import "DisplayMap.h"

@implementation MapKitDisplayViewController

@synthesize mapView;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *theAddress = @"1600 Pennsylvania Ave NW Washington D.C., DC 20500";
	NSString *aTitle = @"a title";
	NSString *aSubtitle = @"a subtitle";
	
	
	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv", 
						   
						   [theAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSString *locationString = [[[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]] autorelease];
	
    NSArray *listItems = [locationString componentsSeparatedByString:@","];
	
	NSLog(@"location: %@", urlString);
	
	NSLog(@"locationString: %@", locationString);
		
	NSString *latS = [listItems objectAtIndex:2];
	
	float lat = [latS floatValue];
	
	
	NSString *lonS = [listItems objectAtIndex:3];
	
	float lon = [lonS floatValue];
	
	
	
	
	
	[mapView setMapType:MKMapTypeStandard];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
	MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
	region.center.latitude = lat ;
	region.center.longitude = lon;
	region.span.longitudeDelta = 0.01f;
	region.span.latitudeDelta = 0.01f;
	[mapView setRegion:region animated:YES]; 
	
	[mapView setDelegate:self];
	
	DisplayMap *ann = [[DisplayMap alloc] init]; 
	ann.title = aTitle;
	ann.subtitle = aSubtitle; 
	ann.coordinate = region.center; 
	[mapView addAnnotation:ann];
}



-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
 (id <MKAnnotation>)annotation {
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapView.userLocation) 
	{
		static NSString *defaultPinID = @"com.invasivecode.pin";
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
										  initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];

		pinView.pinColor = MKPinAnnotationColorRed; 
		pinView.canShowCallout = YES;
		pinView.animatesDrop = YES;
		} 
	else {
		[mapView.userLocation setTitle:@"I am here"];
	}
	return pinView;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mapView release];
    [super dealloc];
}

@end