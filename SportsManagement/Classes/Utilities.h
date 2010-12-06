//
//  Utilities.h
//  SportsManagement
//
//  Created by SelectiveService on 12/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utilities : NSObject {

}

+(NSDate *) dateFromCustomString:(NSString *) dateString;

+(NSString *) dayDateTimeStringOutput:(NSDate *) dateObject;

@end
