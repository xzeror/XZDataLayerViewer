//  Created by Andrey Ostanin on 28.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "TAGDataLayer+CustomProperties.h"

static NSString * const DataLayerModelPropertyName = @"model";

@implementation TAGDataLayer (CustomProperties)
- (NSDictionary*)dataLayerModel{
	NSDictionary *result = (NSDictionary*)[self valueForKey:DataLayerModelPropertyName];
	NSAssert(result, @"Error! TAGDataLayer model is not available with KVC key 'model'");
	return result;
}
@end


