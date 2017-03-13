//
//  DataSourceFabric.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "XZDataSourceFabric.h"
#import "XZDataSourceProtocol.h"
#import "XZHistoryDataSource.h"
#import "XZDictionaryDataSource.h"
#import "XZArrayDataSource.h"
#import "XZStoreProtocol.h"


@implementation XZDataSourceFabric
+ (id<XZDataSourceProtocol>)dataSourceForData:(id)data{
	id<XZDataSourceProtocol> dataSource = nil;
	if ([data conformsToProtocol:@protocol(XZStoreProtocol)]) {
		dataSource = [[XZHistoryDataSource alloc] initWithStore:data];
	}
	else if([data isKindOfClass:[NSDictionary class]]){
		dataSource = [[XZDictionaryDataSource alloc] initWithDictionary:data];
	}
	else if([data isKindOfClass:[NSArray class]]){
		dataSource = [[XZArrayDataSource alloc] initWithArray:data];
	}
	return dataSource;
}
@end
