//
//  DataLayerHistoryWriter.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StoreProtocol;

@interface DataLayerHistoryWriter : NSObject
@property(nonatomic,strong,readonly)id<StoreProtocol> store;
@property(nonatomic,strong,readonly)NSNotificationCenter *notificationCenter;
- (instancetype)initWithStore:(id<StoreProtocol>)store notificationCenter:(NSNotificationCenter*)notificationCenter;
@end
