//
//  EventHistoryDataSource.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSourceProtocol.h"
#import "TAGDataLayer.h"

@interface EventHistoryDataSource : NSObject <DataSourceProtocol>
- (instancetype)initWithDataLayer:(TAGDataLayer*)dataLayer;
@end
