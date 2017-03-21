//  Created by Andrey Ostanin on 07.03.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZCommon.h"

@protocol XZStoreProtocol;

/**
 *  Interface that writer object should support
 */
@protocol XZStoreWriterProtocol
/**
 *	Store to which writer will write data
 */
@property(nonatomic,strong,readonly)id<XZStoreProtocol> store;

/**
 *  Default initializer of writer
 *
 *  @param store injected store to which writer will write data
 *
 *  @return initialized writer instance
 */
- (id<XZStoreWriterProtocol>)initWithStore:(id<XZStoreProtocol>)store;

/**
 *  Write operation
 *
 *  @param data data to be written
 */
- (void)writeDataCopyToStore:(id<NSObject,NSCopying,NSCoding>)data;
@end
