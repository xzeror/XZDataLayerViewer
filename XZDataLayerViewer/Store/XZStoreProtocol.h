//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

/**
 *  Describes interface of storage designed as FIFO
 */
@protocol XZStoreProtocol
/**
 *  Maximum number of history elements that storage will hold
 */
@property(nonatomic,assign)NSUInteger historyLimit;

/**
 *  Default initializer
 *
 *  @param historyLimit maximum history elements that storage will hold
 *
 *  @return initialized instance
 */
- (instancetype)initWithHistoryLimit:(NSUInteger)historyLimit;

/**
 *  Adds object to storage
 *	
 *	This operation should add object to storage and return identifier 
 *	that could be used in objectWithId operation
 *
 *  @param object object to be stored
 *
 *  @return identificator of stored object
 */
- (id)addObject:(id)object;

/**
 *  Gets object from storage by it's identifier
 *
 *  @param identifier identifier of object
 *
 *  @return stored object
 */
- (id)objectWithId:(id)identifier;

/**
 *  Number of objects in storage
 *
 *  @return number of objects
 */
- (NSUInteger)objectsCount;

/**
 *  Get all stored objects
 *
 *  @return array of stored objects
 */
- (NSArray*)objects;
@end
