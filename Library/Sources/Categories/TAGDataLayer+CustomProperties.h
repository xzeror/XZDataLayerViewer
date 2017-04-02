//  Created by Andrey Ostanin on 28.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "TAGDataLayer.h"

/**
 *  Extends TAGDataLayer interface with shortcut to dataLayerModel object
 */
@interface TAGDataLayer (CustomProperties)

/**
 *  Returns customised deep copy of data layer model
 *	Replaces kDataLayerObjectNotPresent during operation
 *
 *  @return deep copy of data layer model
 */
- (NSDictionary*)dataLayerModelDeepCopy;
@end

