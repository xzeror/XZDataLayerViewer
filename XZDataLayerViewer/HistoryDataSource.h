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
- (instancetype)initWithStore:(id<StoreProtocol>)store;
@end
