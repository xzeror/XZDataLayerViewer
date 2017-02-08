//
//  DataSourceFabric.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataSourceProtocol;

@interface DataSourceFabric : NSObject
+ (id<DataSourceProtocol>)dataSourceForData:(id)data;
@end
