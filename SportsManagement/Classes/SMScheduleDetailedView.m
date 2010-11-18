//
//  SMScheduleDetailedView.m
//  SportsManagement
//
//  Created by SelectiveService on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SMScheduleDetailedView.h"
#import "CalendarEvent.h"


@implementation SMScheduleDetailedView

@synthesize event;
@synthesize addLineOneLabel;
@synthesize addCityLabel;
@synthesize addStateLabel;
@synthesize addZipLabel;
@synthesize availSwitch;




-(void)viewWillAppear:(BOOL)animated{
	NSLog(@"made it to the SMScheduleDetaledClass");
	[super viewWillAppear:animated];
	// self.addLineOneLabel.text = self.event.addLineOne;
	
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
	
}
- (void)loadView
{
	[super loadView];
/**
// Custom YES/NO
switchView = [UISwitch switchWithLeftText:@"YES" andRight:@"NO"];
//switchView.center = CGPointMake(160.0f, 60.0f);
switchView.on = YES;
[contentView addSubview:switchView];
 
**/
}
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
