//
//  XZDataLayerViewer - DataSourceFabricTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "XZDataSourceFabric.h"

// Collaborators
#import "XZDataSourceProtocol.h"
#import "XZStoreProtocol.h"
#import "XZHistoryDataSource.h"
#import "XZArrayDataSource.h"
#import "XZDictionaryDataSource.h"


@interface XZDataSourceFabricTest : XCTestCase
@end


@implementation XZDataSourceFabricTest

- (void)setUp {
	[super setUp]; // must be the first line in method
}

- (void)tearDown {
	[super tearDown]; // must be the last line in method
}

#pragma mark - Tests
- (void)testDataSourceShouldReturnHistoryDataSourceForStoreData{
	// given
	id storeMock = OCMProtocolMock(@protocol(XZStoreProtocol));
	
	// then
	[self expectDataSourceShouldReturnObjectOfClass:[XZHistoryDataSource class] forData:storeMock];
}

- (void)testDataSourceShouldReturnArrayDataSourceForArrayData{
	// given
	id arrayMock = OCMClassMock([NSArray class]);
	
	// then
	[self expectDataSourceShouldReturnObjectOfClass:[XZArrayDataSource class] forData:arrayMock];
}

- (void)testDataSourceShouldReturnDictionaryDataSourceForDictionaryData{
	// given
	id dictionaryMock = OCMClassMock([NSDictionary class]);
	
	// then
	[self expectDataSourceShouldReturnObjectOfClass:[XZDictionaryDataSource class] forData:dictionaryMock];
}


#pragma mark - Helpers
- (void)expectDataSourceShouldReturnObjectOfClass:(Class)class forData:(id)data{
	// given
	id<XZDataSourceProtocol> dataSource = nil;
	
	// when
	dataSource = [XZDataSourceFabric dataSourceForData:data];
	
	// then
	expect(dataSource).toNot.beNil();
	expect(dataSource).to.conformTo(@protocol(XZDataSourceProtocol));
	expect(dataSource).to.beAKindOf(class);
}

@end
