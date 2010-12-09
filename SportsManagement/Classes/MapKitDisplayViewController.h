//
//  MapKitDisplayViewController.h
//  MapKitDisplay
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class DisplayMap;

@interface MapKitDisplayViewController : UIViewController <MKMapViewDelegate> {
	
	IBOutlet MKMapView *mapView;
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

@end

