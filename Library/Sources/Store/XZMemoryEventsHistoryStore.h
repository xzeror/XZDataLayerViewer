//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import <Foundation/Foundation.h>
#import "XZStoreProtocol.h"


/**
 *  Default storage that saves values in memory
 */
@interface XZMemoryEventsHistoryStore : NSObject <XZStoreProtocol>
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new  NS_UNAVAILABLE;
@end
