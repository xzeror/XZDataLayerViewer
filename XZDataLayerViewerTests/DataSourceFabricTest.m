//
//  XZDataLayerViewer - DataSourceFabricTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "DataSourceFabric.h"

// Collaborators
#import "DataSourceProtocol.h"
#import "StoreProtocol.h"
#import "HistoryDataSource.h"
#import "ArrayDataSource.h"
#import "DictionaryDataSource.h"


@interface DataSourceFabricTest : XCTestCase
@end


@implementation DataSourceFabricTest

- (void)setUp {
	[super setUp]; // must be the first line in method
}

- (void)tearDown {
	[super tearDown]; // must be the last line in method
}

#pragma mark - Tests
- (void)testDataSourceShouldReturnHistoryDataSourceForStoreData{
	// given
	id storeMock = OCMProtocolMock(@protocol(StoreProtocol));
	
	// then
	[self expectDataSourceShouldReturnObjectOfClass:[HistoryDataSource class] forData:storeMock];
}

- (void)testDataSourceShouldReturnArrayDataSourceForArrayData{
	// given
	id arrayMock = OCMClassMock([NSArray class]);
	
	// then
	[self expectDataSourceShouldReturnObjectOfClass:[ArrayDataSource class] forData:arrayMock];
}

- (void)testDataSourceShouldReturnDictionaryDataSourceForDictionaryData{
	// given
	id dictionaryMock = OCMClassMock([NSDictionary class]);
	
	// then
	[self expectDataSourceShouldReturnObjectOfClass:[DictionaryDataSource class] forData:dictionaryMock];
}


#pragma mark - Helpers
- (void)expectDataSourceShouldReturnObjectOfClass:(Class)class forData:(id)data{
	// given
	id<DataSourceProtocol> dataSource = nil;
	
	// when
	dataSource = [DataSourceFabric dataSourceForData:data];
	
	// then
	expect(dataSource).toNot.beNil();
	expect(dataSource).to.conformTo(@protocol(DataSourceProtocol));
	expect(dataSource).to.beAKindOf(class);
}

@end
