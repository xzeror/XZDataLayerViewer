//
//  XZDataLayerViewer - HistoryDataSourceTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "XZHistoryDataSource.h"

// Collaborators
#import "XZViewModel.h"
#import "XZStoreProtocol.h"
#import "XZEventHistoryElement.h"


@interface XZHistoryDataSourceTest : XCTestCase
@property(nonatomic,strong)XZHistoryDataSource *dataSource;
@property(nonatomic,strong)id dataMock;
@end


@implementation XZHistoryDataSourceTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.dataMock = OCMProtocolMock(@protocol(XZStoreProtocol));
	self.dataSource = [[XZHistoryDataSource alloc] initWithStore:self.dataMock];
}

- (void)tearDown {
	self.dataMock = nil;
	self.dataSource = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Tests
- (void)testDataSourceShouldConformToDataSourceProtocol{
	// given
	// data source setup
	
	// then
	expect(self.dataSource).to.conformTo(@protocol(XZDataSourceProtocol));
}

- (void)testDataSourceShouldReturnCountOfDataElements{
	// given
	NSUInteger testCount = rand();
	OCMStub([self.dataMock objectsCount]).andReturn(testCount);
	
	// then
	expect(self.dataSource.count).to.equal(testCount);
}

- (void)testDataSourceShouldReturnNilViewModelForInvalidIndexPath{
	// given
	id testValue = @1;
	NSIndexPath *validIndexPath = [self setupDataMockToReturnValueAtIndexPath:testValue];
	NSIndexPath *invalidIndexPath = [NSIndexPath indexPathForRow:validIndexPath.row + 1 inSection:validIndexPath.section];
	
	// when
	XZViewModel *viewModel = [self.dataSource viewModelForIndexPath:invalidIndexPath];
	
	// then
	expect(viewModel).to.beNil();
}

- (void)testDataSourceShouldReturnViewModelForValidIndexPath{
	// given
	id testValue = [self eventHistoryElementMock];
	NSIndexPath *validIndexPath = [self setupDataMockToReturnValueAtIndexPath:testValue];
	
	// when
	XZViewModel *viewModel = [self.dataSource viewModelForIndexPath:validIndexPath];
	
	// then
	expect(viewModel).toNot.beNil();
	expect(viewModel.key).toNot.beNil();
	expect(viewModel.value).to.beNil();
	expect(viewModel.shouldShowDisclosureIndicator).to.beTruthy();
}

- (void)testDataSourceShouldReturnNilRawValueForInvalidIndexPath{
	// given
	id testValue = @1;
	NSIndexPath *validIndexPath = [self setupDataMockToReturnValueAtIndexPath:testValue];
	NSIndexPath *invalidIndexPath = [NSIndexPath indexPathForRow:validIndexPath.row + 1 inSection:validIndexPath.section];
	
	// when
	id rawValue = [self.dataSource rawDataForIndexPath:invalidIndexPath];
	
	// then
	expect(rawValue).to.beNil();
}

- (void)testDataSourceShouldReturnRawValueForValidIndexPath{
	// given
	id testValue = [self eventHistoryElementMock];
	NSIndexPath *validIndexPath = [self setupDataMockToReturnValueAtIndexPath:testValue];
	
	// when
	id rawValue = [self.dataSource rawDataForIndexPath:validIndexPath];
	
	// then
	expect(rawValue).to.beIdenticalTo([testValue data]);
}

#pragma mark - Helpers
- (NSIndexPath*)setupDataMockToReturnValueAtIndexPath:(id)value{
	NSIndexPath *validIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
	NSUInteger testCount = validIndexPath.row + 1;
	
	OCMStub([self.dataMock objectWithId:[OCMArg isEqual:@(validIndexPath.row)]]).andReturn(value);
	OCMStub([self.dataMock objectsCount]).andReturn(testCount);
	return validIndexPath;
}

- (XZEventHistoryElement *)eventHistoryElementMock{
	XZEventHistoryElement *eventHistoryElement = OCMClassMock([XZEventHistoryElement class]);
	NSDate *timestamp = [NSDate date];
	NSDictionary *data = @{};
	OCMStub([eventHistoryElement timestamp]).andReturn(timestamp);
	OCMStub([eventHistoryElement data]).andReturn(data);
	return eventHistoryElement;
}
@end
