//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZDataSourceProtocol.h"

/**
 *  Dictionary data source allows interface to get view models
 *	for data saved as dictionary
 */
@interface XZDictionaryDataSource : NSObject <XZDataSourceProtocol>
/**
 *  Creates array data source
 *
 *  @param dictionary dictionary of data
 *
 *  @return data source object
 */
- (instancetype)initWithDictionary:(NSDictionary*)dictionary NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@end
