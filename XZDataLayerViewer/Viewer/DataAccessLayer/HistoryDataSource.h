//
//  HistoryDataSource.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSourceProtocol.h"

@protocol StoreProtocol;

@interface HistoryDataSource : NSObject <DataSourceProtocol>
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithStore:(id<StoreProtocol>)store NS_DESIGNATED_INITIALIZER;
@end
