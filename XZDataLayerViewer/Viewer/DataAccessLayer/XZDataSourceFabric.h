//
//  DataSourceFabric.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XZDataSourceProtocol;

@interface XZDataSourceFabric : NSObject
+ (id<XZDataSourceProtocol>)dataSourceForData:(id)data;
@end
