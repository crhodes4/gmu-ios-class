//
//  MapKitDisplayAppDelegate.h
//  MapKitDisplay
//
//

#import <UIKit/UIKit.h>

@class MapKitDisplayViewController;


@interface MapKitDisplayAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MapKitDisplayViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MapKitDisplayViewController *viewController;

@end

