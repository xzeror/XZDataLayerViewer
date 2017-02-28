//
//  TAGDataLayer+Properties.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 28.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "TAGDataLayer+CustomProperties.h"

static NSString * const DataLayerModelPropertyName = @"model";

@implementation TAGDataLayer (CustomProperties)
- (NSDictionary*)dataLayerModel{
	NSDictionary *result = (NSDictionary*)[self valueForKey:DataLayerModelPropertyName];
	if (result == nil) {
		NSLog(@"Error! TAGDataLayer model is not available with KVC key 'model'");
	}
	return result;
}
@end


