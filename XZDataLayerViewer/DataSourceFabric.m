//
//  DataSourceFabric.m
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import "DataSourceFabric.h"
#import "DataSourceProtocol.h"
#import "DictionaryDataSource.h"
#import "ArrayDataSource.h"

@implementation DataSourceFabric
+ (id<DataSourceProtocol>)dataSourceForData:(id)data{
	id<DataSourceProtocol> dataSource = nil;
	if([data isKindOfClass:[NSDictionary class]]){
		dataSource = [[DictionaryDataSource alloc] initWithDictionary:data];
	}
	else if([data isKindOfClass:[NSArray class]]){
		dataSource = [[ArrayDataSource alloc] initWithArray:data];
	}
	return dataSource;
}
@end
