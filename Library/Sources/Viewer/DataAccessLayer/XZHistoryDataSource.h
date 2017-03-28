//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZDataSourceProtocol.h"

@protocol XZStoreProtocol;

/**
 *  History data source is special object that provides access
 *	to data saved as XZEventHistoryElement objects
 */
@interface XZHistoryDataSource : NSObject <XZDataSourceProtocol>
/**
 *  Initialized data source with store object
 *
 *  @param store store object that conforms to XZStoreProtocol
 *
 *  @return data source object
 */
- (instancetype)initWithStore:(id<XZStoreProtocol>)store NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@end
