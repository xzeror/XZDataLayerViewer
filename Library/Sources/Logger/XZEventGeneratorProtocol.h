//  Created by Andrey Ostanin on 07.03.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZCommon.h"

/**
 *  Defines observer block type.
 *
 *  Event generator should call this block on every generated event
 */
typedef void (^XZEventObservingBlock)(id<NSObject,NSCoding,NSCopying> eventData);

/**
 *  Interface of event generator object
 */
@protocol XZEventGeneratorProtocol
/**
 *  Collection of observing blocks
 */
@property(nonatomic,strong,readonly)NSArray<XZEventObservingBlock> *observers;

/**
 *  Adds observer block to observers collection
 *
 *  @param observingBlock observer block which would be called on every generated event
 *
 *  @return observer identificator that should be used in removeObserver operation
 */
- (id)addObserver:(XZEventObservingBlock)observingBlock;

/**
 *  Removes observer block from collection of observers
 *
 *  @param observerId observer identifier that was previously recieved in addd observer operation
 */
- (void)removeObserver:(id)observerId;
@end
