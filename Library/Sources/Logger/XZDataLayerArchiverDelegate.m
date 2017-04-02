//  Created by Andrey Ostanin on 02.04.17.
//  Copyright © 2017 XZone Software. All rights reserved.

#import "TAGDataLayer.h"
#import "XZDataLayerArchiverDelegate.h"

static NSString *const ObjectNotPresentString = @"ONP";

@implementation XZDataLayerArchiverDelegate : NSObject
- (id)archiver:(NSKeyedArchiver *)archiver willEncodeObject:(id)object{
	if (object == kTAGDataLayerObjectNotPresent) {
		return ObjectNotPresentString;
	}
	return object;
}
@end
