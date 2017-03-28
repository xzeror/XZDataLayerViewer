//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZCommon.h"

@interface XZEventHistoryElement : NSObject
/**
 *  Data that should be saved
 */
@property(nonatomic,strong,readonly)id<NSObject,NSCopying,NSCoding> data;

/**
 *  Timestamp when data was saved
 */
@property(nonatomic,strong,readonly)NSDate *timestamp;

/**
 *  Designated initializer
 *
 *  @param data data that should be saved in history
 *
 *  @return initialized history element
 */
- (instancetype)initWithData:(id<NSObject,NSCopying,NSCoding>)data NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
@end
