//
//  HistoryDataSource.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZDataSourceProtocol.h"

@protocol XZStoreProtocol;

@interface XZHistoryDataSource : NSObject <XZDataSourceProtocol>
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithStore:(id<XZStoreProtocol>)store NS_DESIGNATED_INITIALIZER;
@end
