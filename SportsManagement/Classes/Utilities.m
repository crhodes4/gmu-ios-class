//
//  Utilities.m
//  SportsManagement
//
//  Created by SelectiveService on 12/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Utilities.h"


@implementation Utilities

+(NSDate *) dateFromCustomString:(NSString *) dateString{
	NSRange searchRange = NSMakeRange([dateString length] - 4 , 3);
	dateString = [dateString stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:searchRange];
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
	NSDate *myDate = [df dateFromString: dateString];
	[df release];
	return myDate;
}

+ (NSString *) dayDateTimeStringOutput:(NSDate *) dateObject{
	//produces output like "Mon, 12/03/10     12:00"
	NSDateFormatter* dateFormater = [[NSDateFormatter alloc] init];
	[dateFormater setDateFormat:@"E, M/d/Y   hh:mm"];
	NSString *dateString = [dateFormater stringFromDate:dateObject];
	return dateString;
}

@end
