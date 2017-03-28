//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZDataSourceProtocol.h"

/**
 *  ArrayDataSource allows interface to get view models
 *	for data saved as array
 */
@interface XZArrayDataSource : NSObject <XZDataSourceProtocol>
/**
 *  Creates array data source
 *
 *  @param array array of data
 *
 *  @return data source object
 */
- (instancetype)initWithArray:(NSArray*)array NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@end
