//
//  EventHistoryElement.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZEventHistoryElement : NSObject
@property(nonatomic,strong,readonly)id<NSObject,NSCopying,NSCoding> data;
@property(nonatomic,strong,readonly)NSDate *timestamp;
- (instancetype)initWithData:(id<NSObject,NSCopying,NSCoding>)data;
@end
