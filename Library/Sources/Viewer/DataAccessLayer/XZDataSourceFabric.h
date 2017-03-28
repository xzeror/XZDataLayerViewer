//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZCommon.h"

@protocol XZDataSourceProtocol;

/**
 *  Data source fabric detects type of supplied data and generates 
 *	appropriate data source object
 */
@interface XZDataSourceFabric : NSObject
/**
 *  Create data source appropriate to supplied data
 *
 *  @param data data to which data source should provide access
 *
 *  @return data source object
 */
+ (id<XZDataSourceProtocol>)dataSourceForData:(id)data;
@end
