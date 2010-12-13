//
//  MapKitDisplayViewController.h
//  MapKitDisplay
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class DisplayMap;
@class CalendarEvent;
@class SMScheduleDetailedView;
@class SMLoginViewController;

@interface MapKitDisplayViewController : UIViewController <MKMapViewDelegate> {
	
	IBOutlet MKMapView *mapView;
	CalendarEvent *mapEvents;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CalendarEvent *mapEvents;

@end

