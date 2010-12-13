//
//  MapKitDisplayViewController.m
//  MapKitDisplay
//

#import "MapKitDisplayViewController.h"
#import "DisplayMap.h"
#import "CalendarEvent.h"
#import "SMScheduleDetailedView.h"

#import "SMScheduleDetailedView.h" 

@implementation MapKitDisplayViewController

@synthesize mapView;
@synthesize mapEvents;

- (void)viewDidLoad {
    [super viewDidLoad];
	NSString *temp = mapEvents.addZip;
	
	
	NSString *theAddress = [NSString stringWithFormat:@"%@ %@ %@, %@", mapEvents.addLineOne, mapEvents.addCity, mapEvents.addState, mapEvents.addZip]; 
	
	NSString *aTitle = mapEvents.venueName;

	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv", 
						   
						   [theAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSString *locationString = [[[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]] autorelease];
	
    NSArray *listItems = [locationString componentsSeparatedByString:@","];
	
			
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



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
      return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload {

}


- (void)dealloc {
	[mapView release];
    [super dealloc];
}

@end
