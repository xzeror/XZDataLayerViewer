//  Created by Andrey Ostanin on 28.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "TAGDataLayer.h"

/**
 *  Extends TAGDataLayer interface with shortcut to dataLayerModel object
 */
@interface TAGDataLayer (CustomProperties)

/**
 *  Returns data layer model dictionary object
 *
 *  @return data layer model
 */
- (NSDictionary*)dataLayerModel;
@end

